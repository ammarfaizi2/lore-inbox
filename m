Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbULKVY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbULKVY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbULKVYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:24:25 -0500
Received: from cpc1-addl1-4-0-cust135.herm.cable.ntl.com ([81.96.5.135]:640
	"EHLO kl.asia.com") by vger.kernel.org with ESMTP id S262014AbULKVYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:24:21 -0500
Subject: Improved UTF-8 support for the Linux kernel
From: Simos Xenitellis <S.Xenitellis@rhul.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102769517.3677.38.camel@kl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Dec 2004 12:51:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
The current UTF-8 keyboard input (for the console) of the Linux kernel
does not support  "composing" or writing characters with accents. This
affects quite a few languages that require accents (French, German,
Danish, Swedish?, Greek, cyrillic-based?, others?.). 

In general, UTF-8
console support is good to display text in different character sets,
enabling to configure a distribution to use UTF-8 locales for both
console/Xorg.

While looking into the problem, I noticed that there is work to make
Linux console handle Unicode better.

Two links are of interest
A. Improved UTF-8 support for the Linux kernel, by Chris Heath
http://chris.heathens.co.nz/linux/utf8.html
B. Notes on the Linux console, by Innocenti Maresin
http://www.comtv.ru/~av95/linux/console/

Discussion on these issues take place at
http://groups-beta.google.com/group/nlo.lists.linux-utf8

Chris Heath has a set of incremental patches
(http://chris.heathens.co.nz/linux/utf8.html) to enhance Unicode for the
console.
I noticed that he contacted this list in May 2003
(http://seclists.org/lists/linux-kernel/2003/May/7956.html) but
unfortunatelly the discussion was diverted to coding styles.

Is there an interest for re-submission of mentioned patches for
inclusion in the kernel (yeah, provided coding style is normalised)?

Simos

p.s.
I am not sending this e-mail on behalf of any of the authors, just
myself.
