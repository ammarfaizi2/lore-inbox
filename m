Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUEQP0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUEQP0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUEQP0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:26:16 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:62897 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261638AbUEQPYC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:24:02 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-15.tower-45.messagelabs.com!1084807438!2416841
X-StarScan-Version: 5.2.11; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
Date: Mon, 17 May 2004 11:23:37 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7605FAE6AC@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
Thread-Index: AcQ6yVeBMlJYfp+xQ1aEOp2X0K6lLQBWWRIA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does creative still help maintain this module?
Is there an #include <string-something.h> missing in the module (WHEN
COMPILED W/SMP support, or?)
jpiszcz@slack91:/usr/src/linux/Documentation$ find .|grep -i emu101k
jpiszcz@slack91:/usr/src/linux/Documentation$ find .|grep -i emu101
jpiszcz@slack91:/usr/src/linux/Documentation$ grep emu101k -r *
grep: networking/netif-msg.txt: Permission denied
grep: scsi/ChangeLog.megaraid: Permission denied
jpiszcz@slack91:/usr/src/linux/Documentation$

(2.6.5 kernel)

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
Sent: Saturday, May 15, 2004 6:08 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.

Let me remind all; this is with _SMP_ kernel only, with a regular kernel
it makes the module and loads it fine.

Anyone aware of this problem?

On Sat, 15 May 2004, Justin Piszcz wrote:

> Script started on Sat May 15 14:47:08 2004
> # modprobe emu10k1
> FATAL: Error inserting emu10k1
> (/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown
symbol
> in module, or unknown parameter (see dmesg)
> root@war:~# dmesg | tail -n 1
>  emu10k1: Unknown symbol strcpy
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


