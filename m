Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKVLAD>; Wed, 22 Nov 2000 06:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKVK7o>; Wed, 22 Nov 2000 05:59:44 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:31785 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129231AbQKVK7j>; Wed, 22 Nov 2000 05:59:39 -0500
Message-ID: <3A1BA00E.7BA78AA@linux.com>
Date: Wed, 22 Nov 2000 02:29:34 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: test11 spontaneous reboot
Content-Type: multipart/mixed;
 boundary="------------6BEC1338E29F11B786652FEB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BEC1338E29F11B786652FEB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Something appears to be broken.  One of my servers is going through
seemingly random spontaneous reboots with nothing to indicate why.

model name      : Pentium III (Coppermine)
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse

It's a VIA Technologies chipset.  I had no problems with it on test8, it
ran happily for 29 days before the upgrade.  I build the kernel on the
same machine (nec versa lx) that I build with for all my other software.

boot dmesg is at http://stuph.org/dmesg-lastboot, I don't have anything
else to go on at the moment, consider this a heads up that something is
broken.

-d


--------------6BEC1338E29F11B786652FEB
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

--------------6BEC1338E29F11B786652FEB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
