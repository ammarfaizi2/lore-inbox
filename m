Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277235AbRJQWAw>; Wed, 17 Oct 2001 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJQWAm>; Wed, 17 Oct 2001 18:00:42 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:58130 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S277235AbRJQWA0>; Wed, 17 Oct 2001 18:00:26 -0400
Message-ID: <3BCDFADD.B61F0E8B@eisenstein.dk>
Date: Wed, 17 Oct 2001 23:40:45 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: myrdraal@deathsdoor.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] _very_ minor changes to Documentation/sysrq.txt
Content-Type: multipart/mixed;
 boundary="------------57DBB9D07757B58F79DE78ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------57DBB9D07757B58F79DE78ED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, 

I was reading Documentation/sysrq.txt and a few things struck me as
slightly wrong, so I corrected them and created a patch. If you think
these changes are correct, then please consider applying - otherwise
just ignore it.

Patch attached as "2.4.13-pre3-sysrq_txt.patch" and is against
2.4.13-pre3.

Best regards,
Jesper Juhl
juhl@eisenstein.dk
--------------57DBB9D07757B58F79DE78ED
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-sysrq_txt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-sysrq_txt.patch"

--- linux-2.4.13-pre3-orig/Documentation/sysrq.txt	Tue Sep 18 07:52:35 2001
+++ linux-2.4.13-pre3/Documentation/sysrq.txt	Wed Oct 17 23:34:45 2001
@@ -83,8 +83,8 @@
 when you would try to login. It will kill all programs on given console
 and thus letting you make sure that the login prompt you see is actually
 the one from init, not some trojan program.
-IMPORTANT:In its true form it is not a true SAK like the one in   :IMPORTANT
-IMPORTANT:c2 compliant systems, and it should be mistook as such. :IMPORTANT
+IMPORTANT:In its true form it is not a true SAK like the one in c2 :IMPORTANT
+IMPORTANT:compliant systems, and it should not be mistaken as such.:IMPORTANT
        It seems other find it useful as (System Attention Key) which is
 useful when you want to exit a program that will not let you switch consoles.
 (For example, X or a svgalib program.)
@@ -101,7 +101,7 @@
 'U'mount is basically useful in the same ways as 'S'ync. I generally 'S'ync,
 'U'mount, then re'B'oot when my system locks. It's saved me many a fsck.
 Again, the unmount (remount read-only) hasn't taken place until you see the
-"OK" and "Done" message appear on the screen.
+"OK" and "Done" messages appear on the screen.
 
 The loglevel'0'-'9' is useful when your console is being flooded with
 kernel messages you do not want to see. Setting '0' will prevent all but

--------------57DBB9D07757B58F79DE78ED--

