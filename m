Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTGDRTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTGDRTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:19:05 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:16650 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S264271AbTGDRTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:19:01 -0400
Message-ID: <002501c34252$c8d10980$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: <linux-kernel@vger.kernel.org>
References: <4R5X.8bo.19@gated-at.bofh.it> <4Rzh.h8.25@gated-at.bofh.it> <4WSg.5H7.21@gated-at.bofh.it> <5h0y.5ht.25@gated-at.bofh.it> <5iIR.7Cp.11@gated-at.bofh.it> <5iIQ.7Cp.9@gated-at.bofh.it> <5jOA.14o.9@gated-at.bofh.it> <5lnu.2l7.13@gated-at.bofh.it>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Fri, 4 Jul 2003 14:36:21 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I passed the parameer: nmi_watchdog=1 to the kernel at the boot.

And after about 2 hours it frozen again, but in the console I found a lot of
messages like this:

smb_proc_readdir_log: name=\....(some directory)....\*, result=-2, rcls=1,
err=2

In the log, I found the same message:

Jul  4 12:35:21 filitico kernel: smb_proc_readdir_long:
name=\Renato(19)\Data Base Nao Utilizados\*, result=-2, rcls=1, err=2

and

Jul  4 12:30:07 filitico kernel: smb_proc_readdir_long:
name=\Renato(19)\Data Base Nao Utilizados\*, result=-2, rcls=1, err=2
Jul  4 12:30:54 filitico kernel: smb_proc_readdir_long:
name=\Renato(19)\Data Base Nao Utilizados\*, result=-2, rcls=1, err=2
Jul  4 12:33:59 filitico last message repeated 3 times
Jul  4 12:34:24 filitico last message repeated 2 times

Do you know what possible it can be ?

Thanks
Slepetys


----- Original Message ----- 
From: "Jim Gifford" <maillist@jg555.com>
Newsgroups: linux.kernel
Sent: Thursday, July 03, 2003 8:10 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> Justin, I just tried to enable the nmi watch dog. It doesn't seem to work
on
> my system I tried both
>
> append="nmi_watchdog=1"
> and
> append="nmi_watchdog=2"
>
> ----- Original Message ----- 
> From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>; "Jim Gifford"
> <jim@jg555.com>; <linux-kernel@vger.kernel.org>
> Sent: Thursday, July 03, 2003 2:20 PM
> Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
>
>
> > > I have no clue for what kind of tests I can do to generate the
trouble,
> or
> > > for what logs, or files to look for.
> >
> > Have you tried running with the NMI watchdog enabled?
> >
> > --
> > Justin
> >
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


