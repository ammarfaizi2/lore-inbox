Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUKJJkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUKJJkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKJJkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:40:33 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:64423 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261527AbUKJJkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:40:11 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 10 Nov 2004 09:40:11 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Nov 2004 04:40:10 -0500
Subject: broken gcc 3.x update ("3.4.3""fixed")
X-Originating-Ip: 172.171.49.25
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20041110094011.0A3434BE64@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apropos of the recent "older compilers" discussion,
the string literal concatenation pre-processor bug
that I mentioned encountering in gcc-3.3.x and
gcc-3.4.[0,1] appears to be fixed in gcc-3.4.3.
(It was not the well-known "##" token pasting
pre-processor bug, incidentally.)

I've only tested with glibc-2.2.5 so far,
but I could reproduce it before with both
glibc-2.2.5 and glibc-2.3.2, so it probably
really is fixed.

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

