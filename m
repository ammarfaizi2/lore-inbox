Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277359AbRJJSjZ>; Wed, 10 Oct 2001 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJJSjQ>; Wed, 10 Oct 2001 14:39:16 -0400
Received: from mk-smarthost-2.mail.uk.worldonline.com ([212.74.112.72]:5640
	"EHLO mk-smarthost-2.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S277361AbRJJSjA>; Wed, 10 Oct 2001 14:39:00 -0400
To: linux-kernel@vger.kernel.org
From: <jonathan@daria.co.uk (Jonathan R. Hudson)>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: usb:raced timeout in 2.4.11
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <58a.3bc495e0.d0ec3@trespassersw.daria.co.uk>
Date: Wed, 10 Oct 2001 18:39:28 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the last USB changes, the uhci modules emits a lot of
messages:

kernel: usb: raced timeout, pipe 0x80000180 status 0 time left 0
kernel: usb: raced timeout, pipe 0x80000100 status 0 time left 0

approx 50 on one box, and around 20 on another.

This message does not occur with the usb-uhci module.

Someone disconcerting. Systems still talk to the camera ...

