Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSGBCtP>; Mon, 1 Jul 2002 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSGBCtO>; Mon, 1 Jul 2002 22:49:14 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16043
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316599AbSGBCtO>; Mon, 1 Jul 2002 22:49:14 -0400
Date: Mon, 1 Jul 2002 19:48:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020702024825.GI20920@opus.bloom.county>
References: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com> <20020701181228.GF20920@opus.bloom.county> <20020701234432.GC1697@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020701234432.GC1697@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 01:44:32AM +0200, J.A. Magallon wrote:
> 
> On 2002.07.01 Tom Rini wrote:
> >On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
> >
> >> What's the issue?
> >
> >b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
> >to 2.4, it'd be just like 2.5 :)
> 
> So you want to wait till 2.6.40 to be able to use a O1 scheduler on a
> kernel that does not eat up your drives ? (say, next year by this same month...)

I assume you mean 2.4.60 here, and no, I don't think O1 scheduler should
go into 2.4 ever.  We're aiming for a _stable_ series here.  Let me
stress that again, _stable_.  I'd hope that 2.4.60 is as slow in coming
as 2.0.40 is.

> >c) I also suspect that it hasn't been as widley tested on !x86 as the
> >stuff currently in 2.4.  And again, 2.4 is the stable tree.
> 
> I know it is not a priority for 2.4, but say it wil never happen...

I won't say it will never happen, just that I don't think it should.
It's a rather invasive thing (and as Ingo said, it's just not getting
stable).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
