Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLAMKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 07:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTLAMKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 07:10:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:19164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263102AbTLAMKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 07:10:22 -0500
X-Authenticated: #2203603
Message-ID: <01b901c3b803$d6c8c380$7727048b@de.uu.net>
From: "Daniel Flinkmann" <dflinkmann@gmx.de>
To: "Kieran" <kieran@ihateaol.co.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <00c801c3b7f5$eafb8ad0$7727048b@de.uu.net> <3FCB2D95.70709@ihateaol.co.uk>
Subject: Re: PROBLEM: Corrupt files with kernel 2.6.0_test11 and smb mounts
Date: Mon, 1 Dec 2003 13:08:26 +0100
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

Kieran,

> I'm running 2.6.0-test11 and this doesn't seem to affect me.
> 
> # cd /mnt/smb/
> # echo test1234567890 > test.txt
> # cat test.txt
> test1234567890
> # echo hi! > test.txt
> # cat test.txt
> hi!
> # df -hT | grep smb
> //192.168.0.1/smb  smbfs  74G  43G  31G  58% /mnt/smb
> 
> Is the samba version relevant? 2.2.8 here.
> Need any more info?

could you be so kind and send me your kernel .config  ? 
I will have a look where the differences are. I believe that it's not a 
server related issue, because Kernel 2.4.xx is working fine. 

I will compare both kernel configs and hopefully I find something.

Thanks in advance,

Daniel

