Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbRERS0v>; Fri, 18 May 2001 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbRERS0l>; Fri, 18 May 2001 14:26:41 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:26633 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261424AbRERS03>;
	Fri, 18 May 2001 14:26:29 -0400
Date: Fri, 18 May 2001 14:25:08 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518142508.B16093@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518123413.I14309@thyrsus.com> <E150o7n-0007PV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150o7n-0007PV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 06:33:15PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Do you really believe anyone would be dumb enough to delete them out of spite
> or to further your political machinations if they could both handle the same
> configuration language.

That's a big "if" which I don't think is ever going to happen.  The
CML1 and CML2 languages are nowhere near semantically equivalent.  I
know them both intimately, and bridging the gap is a much harder
problem than you seem prepared to realize.

They look closer together than they are, because you can superficially
map individual features between them (CML2 derivations look like CML1
defines, for example).  The big difference is subtler, and has to do with
the difference between a control language and a constraint language.  As
a result, there are things you can easily do in CML2 that you can't 
practically speaking do in CML1.

For CML1 and CML2 to handle the same language, we would either have
to live with the CML1 language's limitations or retrofit the old tools
to speak CML2 language.  The chance of the latter happening is, I think
we can agree, effectively zero.

I know you've talked about parsing CML1 into constraints with
backtracking.  Maybe you're smart enough to do that.  I'm not.  I
tried that route early on.  I predict that if you do, you'll
experience a great deal of suffering, acquire a valuable education,
and get no good result.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The common argument that crime is caused by poverty is a kind of
slander on the poor.
	-- H. L. Mencken
