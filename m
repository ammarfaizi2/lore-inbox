Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031669AbWLABCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031669AbWLABCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031671AbWLABCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:02:37 -0500
Received: from web83014.mail.mud.yahoo.com ([209.191.87.20]:16800 "HELO
	web83014.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031669AbWLABCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:02:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=fAjTgVRJZuq/Xm7pOMyGszWbKRvhY3g7PGZoZz4GJt53MThUkAPSVwqLaeAUwopb0Yl8+Wgz18ZOSVg7P9B4h+HA41ifJxI4LnqhbOFmPJ9vS9nhxnLSenvDW/NfihSaYPBTdrEvaNyYDp4IYuLVV/AVqEHoBSu9vjZmB9EmmTo=;
X-YMail-OSG: Q958sk4VM1llHKtV2VzNImo73Hgi0ggubIlv2Ar.Ks_JybI8lD06sjfnLgBCJE0I4oXmONAnb7nhU4N6A1IeJ.bllzU3jUmvnPn5ZpKOp05KAZnF7pdkiS59yUzur.0JUBdS8JY8PQAmEjs-
Date: Thu, 30 Nov 2006 17:02:35 -0800 (PST)
From: Brad Littlejohn <tyketto@sbcglobal.net>
Subject: kernels > 2.6.17.14 hang at boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <51557.56573.qm@web83014.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've tried to send this a number of times, but don't
think it ever made it through, so I'll give it one
more go.

I've given every stable kernel release newer than
2.6.17.14 a compile and run, and each time, I am
getting the same hangup as the kernel boots.

For 2.6.18.*, I get the following:

--snip--
kernel driver mapping tables up to 100000000 @
8000-d000
--snip--

Nothing more. For 2.6.19:

--snip--
kernel is alive
kernel driver mapping tables up to 100000000 @
8000-d000
--snip--

Nothing more. Outside of any new options added to make
config, I am using the same .config as 2.6.17.14,
which runs perfectly. I'm running this on native
x86_64, if it helps; slamd64 (Slackware derivative) is
the distro. everything is stock from that (gcc 3.4.6,
libc-2.3.6, make-3.81, binutils-2.16.92).

Any ideas? If you need the .config, let me know and
I'll include it.

BL.

