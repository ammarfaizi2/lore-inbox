Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbQKCGGj>; Fri, 3 Nov 2000 01:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbQKCGG3>; Fri, 3 Nov 2000 01:06:29 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:44712 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129304AbQKCGGR>; Fri, 3 Nov 2000 01:06:17 -0500
Message-ID: <3A0255CC.BC1441AE@linux.com>
Date: Thu, 02 Nov 2000 22:06:04 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [bug] NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: multipart/mixed;
 boundary="------------DF9AB5FD46913B9146997E63"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF9AB5FD46913B9146997E63
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok, something happend to the tulip driver in the recent testN kernels.
I haven't found a reason why it happens and I can't easily reproduce it
but what happens is noted on the subject line.

I have three machines now that do this.  It's unfixable until reboot (I
don't have these as modules).

I have a suspicion that it's triggered by large amounts of traffic.  My
brother feels he is able to trigger it repeatedly by doing big transfers
between a w9x box and a linux box.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------DF9AB5FD46913B9146997E63
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------DF9AB5FD46913B9146997E63--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
