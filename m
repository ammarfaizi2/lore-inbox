Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293091AbSCOSpU>; Fri, 15 Mar 2002 13:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293122AbSCOSpC>; Fri, 15 Mar 2002 13:45:02 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:19945 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S293091AbSCOSor>; Fri, 15 Mar 2002 13:44:47 -0500
Message-ID: <005401c1cc51$ab6c3fe0$1a02a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Jeremy Jackson" <jerj@coplanar.net>, <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020315013644.A26891@morpheus> <016401c1cc02$aa51c110$7e0aa8c0@bridge>
Subject: Re: unwanted disk access by the kernel?
Date: Fri, 15 Mar 2002 13:46:06 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You may also want to mount your (root) filesystem(s) with the
> "noatime" option... check the linux laptops site for other tips.

Thanks Jeremy and Alan - mounting the filesystems 'noatime,nodiratime'
cleared up the last bits of disk activity. (I'm still curious why atime
updates would be happening even though the system is as idle as I can make
it without cutting the power... =)

By the way, if I enable 'APM makes CPU idle calls when idle,' I get a
constant stream of 'apm_do_idle failed (3)' messages. APM also doesn't seem
to be able to power the machine down... This is a Dell Inspiron 7500...
Maybe I should try ACPI?

Regards,
Dan

