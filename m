Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFVMvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFVMvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFVMvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:51:41 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:28053
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261255AbVFVMvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:51:21 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>
Cc: "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [ltp] Re: IBM HDAPS Someone interested?
Date: Wed, 22 Jun 2005 06:50:59 -0600
Message-ID: <001201c57729$0a645840$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050622104927.GB2561@openzaurus.ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
>
> > > I'm trying to do watch -n1 cat /proc/acpi/ibm/ecdump, But
> I don't have
> > > ecdump. I'm with ibm-acpi 0.8
> > >
> >
> > I was thinking more along the lines of figure out the io port it's
> > using, then boot windows, set an IO breakpoint in softice, then drop
> > your laptop on the bed or something.
>
> It should be enough to tilt your laptop so that it parks
> heads... safer than
> dropping it.
>
> And perhaps easier solution is to locate the sensor on the
> mainboard, and
> trace where it is connected with magnifying glass (as vojtech
> already suggested).
>
> 				Pavel
>
> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51
> time=448769.1 ms
>

/proc/acpi/ibm/ecdump is really not providing any information about this
sensor. yesterday, I almost broke the laptop to see if it would generate
anything, but it really only outputs ACPI events...

I shaked it, moved it 90deg and still no result, threw the lappy from like
40cm to the bed and nothing was really generated. Unless it is too fast like
to generate it in the watch or to be seen by human eye. I dunno.

It looks like /ecdump won't do it.

.Alejandro

