Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTGNUZC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270774AbTGNUXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:23:38 -0400
Received: from web60006.mail.yahoo.com ([216.109.116.229]:18095 "HELO
	web60006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270782AbTGNUUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:20:44 -0400
Message-ID: <20030714203532.42765.qmail@web60006.mail.yahoo.com>
Date: Mon, 14 Jul 2003 21:35:32 +0100 (BST)
From: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
Subject: Re: Kernel oops with 2.5.74 2.5.75
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0307141643040.484-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-470323768-1058214932=:40772"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-470323768-1058214932=:40772
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
wrote: > 
> Please send dmesg with oops
> (make sure you have CONFIG_KALLSYMS enabled).
> 

just updated to 2.6-test1 with the same result
I attach the output on the screen (written down and copied, so may be
errors)

this occurs after loading ide1
> --
> Bartlomiej
> 
> On Mon, 14 Jul 2003, [iso-8859-1] Mike Martin wrote:
> 
> > I am getting a kernel oops with both these kernels as soon as it
> the
> > kernel loads the ide drivers (hd*)
> >
> > I am using ALI1542 chipset, K6/2 500 cpu
> > I have tried progressively disabling various ide options (cramfs,
> > acls tcq etc) to no effect
> >
> > I run ext3 compiled in
> >
> > This is on a base of RH9 with updated modutils from rawhide.
> >
> > The kernel apparrently compiles fine (no errors)
> >
> > Anyone any ideas what could be the cause of this (2.5.66 worked
> on
> > this machine and runs 2.4.21 fine)
> >
> > If its not a simple fix I will bugzilla it
>  

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
--0-470323768-1058214932=:40772
Content-Type: application/octet-stream; name=kern_oops
Content-Transfer-Encoding: base64
Content-Description: kern_oops
Content-Disposition: attachment; filename=kern_oops

WzxjMDMxNzc1YT5dIHBhZ2V2ZWNfbG9va3VwKzB4MWEvMHg0MApbPGMwMTM3
NmM4Pl0gaW52YWxpZGF0ZV9tYXBwaW5nX3BhZ2VzKzB4NDgvMHgxMDAKWzxj
MDEzN2M4ZD5dIGludmFsaWRhdGVfaW5vZGVfcGFnZXMrMHhkLzB4MjAKWzxj
MDE0N2Y3ZD5dIGtpbGxfYmRldisweGQvMHg0MApbPGMwMTUwODI2Pl0gYmxr
ZGV2X3B1dCsweDY2Lzd4MWFvCls8YzAxNzU0YTI+XSByZWdpc3Rlcl9kaXNr
KzArMTAyLzB4MTQwCls8YzAyNDFhNzE+XSBhZGRfZGlzaysweDMxLzB4NDAK
WzxjMDI0MWEwMD5dIGV4YWN0X21hdGNoKzB4MC8weDIwCls8YzAyNDFhMjA+
XSBleGFjdF9sb2NrKzB4MC8weDIwCls8YzAyNWM0NDI+XSBpZGVkaXNrX2F0
dGFjaCswKzEwMi8weDE4MApbPGMwMjU3ZmNjPl0gYXRhX2F0dGFjaCsweDhj
LzB4MWMwCls8YzAyNTkxMzE+XSBpZGVfcmVnaXN0ZXJfZHJpdmVyKzB4ZjEv
MHgxMjAKWzxjMDI1YzRjYT5dIGlkZV9kaXNrX2luaXQrMHhhLzB4MjAKWzxj
MDNjYTc2Yz5dIGRvX2luaXRjYWxscysweDJjLzB4YTAKWzxjMDEwNTBhYj5d
IGluaXQrMHgyNi8weGFvCls8YzAxMDUwODA+XSBpbml0KzB4MC8weDFhbwpb
PGMwMTA3MDI1Pl0ga2VybmVsX3RocmVhZF9oZWxwZXIrMHg1LzB4MjAK

--0-470323768-1058214932=:40772--
