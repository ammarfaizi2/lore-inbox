Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271919AbTHMMHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHMMHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:07:24 -0400
Received: from mta9.adelphia.net ([64.8.50.199]:46732 "EHLO mta9.adelphia.net")
	by vger.kernel.org with ESMTP id S271129AbTHMMHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:07:21 -0400
Message-ID: <00ac01c36193$72c892a0$6401a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "gaxt" <gaxt@rogers.com>,
       =?iso-8859-15?Q?Henrik_R=E6der_Clausen?= <henrik@fangorn.dk>,
       "Francois Romieu" <romieu@fr.zoreil.com>,
       <linux-kernel@vger.kernel.org>,
       "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
       "Brown, Len" <len.brown@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Mark W. Alexander" <slash@dotnetslash.net>,
       "Thomas Molina" <tmolina@cablespeed.com>,
       "Christian Mautner" <chm@istop.com>,
       "Andrey Borzenkov" <arvidjaar@mail.ru>,
       =?iso-8859-15?Q?Herbert_P=F6tzl?= <herbert@13thfloor.at>,
       "Norbert Preining" <preining@logic.at>
References: <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <1060436885.467.0.camel@teapot.felipe-alfaro.com> <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030813061546.GB24994@gamma.logic.tuwien.ac.at>
Subject: Re: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Date: Wed, 13 Aug 2003 08:07:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope...  For the reported problem I had with grub and root=/dev/hda3, it was
with a fresh tar file.

As someone said, this "can't happen".  And as someone else said, "It comes
and goes with random changes in .config file"

jeff

----- Original Message ----- 
From: "Norbert Preining" <preining@logic.at>
To: "gaxt" <gaxt@rogers.com>; "Henrik Ræder Clausen" <henrik@fangorn.dk>;
"Francois Romieu" <romieu@fr.zoreil.com>; <linux-kernel@vger.kernel.org>;
"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>; "Mr. James W.
Laferriere" <babydr@baby-dragons.com>; "Brown, Len" <len.brown@intel.com>;
"Andrew Morton" <akpm@osdl.org>; "Mark W. Alexander"
<slash@dotnetslash.net>; "jeff millar" <wa1hco@adelphia.net>; "Thomas
Molina" <tmolina@cablespeed.com>; "Christian Mautner" <chm@istop.com>;
"Andrey Borzenkov" <arvidjaar@mail.ru>; "Herbert Pötzl"
<herbert@13thfloor.at>
Sent: Wednesday, August 13, 2003 2:15 AM
Subject: SOLUTION Re: 2.6.0-test3 cannot mount root fs


> On Die, 12 Aug 2003, Christian Mautner wrote:
> > Hast du auch einen kompletten Kernel tarball versucht? Wahrscheinlich
>
> The solution is:
> Get a COMPLETE linux-2.6.0-test3.tar.bz2
> and
> DO NOT USE patch
>
> I patched up the kernel from 2.5.20 or something and there seemed to be
> an error somewhere on the way up. Getting a *clean* kernel tar file,
> compile with the same .config, running.
>
> This is the use of patches!
>
> Best wishes
>
> Norbert
>
> --------------------------------------------------------------------------
-----
> Norbert Preining <preining AT logic DOT at>         Technische Universität
Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5
B094
> --------------------------------------------------------------------------
-----
> AINDERBY STEEPLE (n.)
> One who asks you a question with the apparent motive of wanting to
> hear your answer, but who cuts short your opening sentence by leaning
> forward and saying 'and I'll tell you why I ask...' and then talking
> solidly for the next hour.
> --- Douglas Adams, The Meaning of Liff
>

