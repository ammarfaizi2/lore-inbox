Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSGWS5n>; Tue, 23 Jul 2002 14:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSGWS5n>; Tue, 23 Jul 2002 14:57:43 -0400
Received: from handhelds.org ([192.58.209.91]:22486 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S318168AbSGWS5n>;
	Tue, 23 Jul 2002 14:57:43 -0400
From: George France <france@handhelds.org>
To: "Martin Brulisauer" <martin@uceb.org>
Subject: Re: kbuild 2.5.26 - arch/alpha
Date: Tue, 23 Jul 2002 15:00:50 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Jay Estabrook <Jay.Estabrook@hp.com>
References: <3D3D6B3B.25754.1392D3FD@localhost> <3D3DA7F3.9275.1480075C@localhost>
In-Reply-To: <3D3DA7F3.9275.1480075C@localhost>
MIME-Version: 1.0
Message-Id: <02072315005002.31958@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 July 2002 13:01, Martin Brulisauer wrote:
> On 23 Jul 2002, at 11:05, George France wrote:
> > that version for a while until it is stable.  In the past few months most
> > of the efforts have been spent on 2.4.9.  Currently there have been
> > discussions in regard to:
> >
> > 1) porting all those patches for 2.4.9 forward to 2.4.[18-19] and 2.5.x.
>
> I am currently running 2.4.18 from SuSE without any (major)
> problems. I found it here:
> ftp://ftp.suse.com/pub/people/sf/axp/7.1/RPMS/kernel-source-
> 2.4.18.SuSE-0.alpha.rpm.
> Then I took arch/alpha/kernel/core_cia.c from version 2.4.12
> (the current version does not run on XLT's booting with MILO;
> the latest one is 2.4.12).

I have not tried Stefan's 2.4.18 kernel.  I am glad to hear that it works for 
you.  I will give it a try.

> > 2) taking a look at the latest 2.5.x in the next few weeks, as we are
> > aware that 2.5.x does not compile on Alpha.
>
> Hopefully I can fix core_cia.c to run on XLT's (it's hard to find any
> documentation on this toppic) and arch/alpha/kernel/setup.c for
> machines booting with linload.exe/MILO because the hwrpb
> struct is built by MILO and does not match the one booting from
> SRM (eg. empty percpu struct resulting in a cpucount of zero
> in /proc/cpuinfo).

I am not very familiar with the XLT systems. Maybe Jay can help.  He has been 
working on Alpha systems for a very long time.

Jay, do you have any suggestions???

Best Regards,


--George
