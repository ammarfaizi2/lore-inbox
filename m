Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWFHK0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWFHK0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFHK0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:26:45 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:9603 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932116AbWFHK0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:26:44 -0400
Subject: 2.6.17-rc6, bcm43xx and WPA
From: Andreas Rittershofer <andreas@rittershofer.de>
Reply-To: andreas@rittershofer.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 08 Jun 2006 12:26:32 +0200
Message-Id: <1149762392.3781.7.camel@coredump>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-ID: E2tQguZ-8e6WSSd+3O0MYYXJDtLWAQfhhhee4tGzA6Xr6uwJWVZ00E@t-dialin.net
X-TOI-MSGID: a27bf992-0e27-425f-9637-5d1ddd2e9e5c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've installed kernel 2.6.17-rc6 and activited the bcm43xx-driver for my
Broadcom-Chip in my notebook, also softmac, ...

The wlan-driver is loaded successfully, I can set all parameters and so
on.

I also installed wpa_supplicant without problems.

Authentication to my AP is not possible, the problem seems to be:

ioctl[SIOCSIWENCODEEXT]: Invalid argument
Driver did not support SIOCSIWENCODEEXT
WPA: Failed to set PTK to the driver.


So it seems that the bcm43xx-driver included in this kernel versions is
not ok - I cannot connect to my AP using WPA.

Any hints?

mfg ar

-- 
E-Learning in der Schule:
http://www.dbg-metzingen.de/Menschen/Lehrer/Q-T/Rittershofer/E-Learning/

