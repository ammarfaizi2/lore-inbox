Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283314AbRK2Qha>; Thu, 29 Nov 2001 11:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283313AbRK2QhV>; Thu, 29 Nov 2001 11:37:21 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:44427
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283314AbRK2QhJ>; Thu, 29 Nov 2001 11:37:09 -0500
Date: Thu, 29 Nov 2001 11:30:23 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Cowan <jcowan@reutershealth.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.9.2 is available
Message-ID: <20011129113023.B16711@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Cowan <jcowan@reutershealth.com>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011129060048.A11216@thyrsus.com> <3C0651E5.10908@reutershealth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0651E5.10908@reutershealth.com>; from jcowan@reutershealth.com on Thu, Nov 29, 2001 at 10:19:01AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cowan <jcowan@reutershealth.com>:
> > Keith has pointed out a weakness in the language -- there's no way to make
> > the default value of a choices menu dependent on the architecture (an issue
> > for things like kcore format).  I am meditating on this.
>  
> Suggestion: allow a derived symbol as the default.  It must be possible
> to prove that the value of this symbol is going to be one of the
> choices.

The problem here is that the derivation would yield a value, but in
this context we need it to yield a *name*.  The `default' clause of
choices is, semantically, a name-valued expression.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Today, we need a nation of Minutemen, citizens who are not only prepared to
take arms, but citizens who regard the preservation of freedom as the basic
purpose of their daily life and who are willing to consciously work and
sacrifice for that freedom."	-- John F. Kennedy
