Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130463AbQKSLRF>; Sun, 19 Nov 2000 06:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131790AbQKSLQz>; Sun, 19 Nov 2000 06:16:55 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:4905 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130463AbQKSLQs>; Sun, 19 Nov 2000 06:16:48 -0500
Message-ID: <3A17AF88.F1319C2C@linux.com>
Date: Sun, 19 Nov 2000 02:46:32 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de> <20001118141426.B23033@almesberger.net> <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de>
Content-Type: multipart/mixed;
 boundary="------------E48A413646B728A179A7D2FC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E48A413646B728A179A7D2FC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerd Knorr wrote:

> Why?  What is the point in compiling bttv statically into the kernel?
> Unlike filesystems/ide/scsi/... you don't need it to get the box up.
> No problem to compile the driver as module and configure it with
> /etc/modules.conf ...

Huh?

Some systems are built without module support for numerous reasons.  I don't
need 50% of the entire kernel to get the box up, but I surely use it and I
don't want 100 modules loaded.  There is an introduced security weakness by
using kernels.  There are module races.  There are ...

So..what is the point in making it modular?  ..if it's in use the entire time
the machine is booted?

-d


--------------E48A413646B728A179A7D2FC
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------E48A413646B728A179A7D2FC--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
