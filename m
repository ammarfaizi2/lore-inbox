Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbUKIRZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbUKIRZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUKIRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:25:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27918 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261592AbUKIRZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:25:55 -0500
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Move check for invalid chars to
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013524.GB6835@neapel230.server4you.de>
	<87actr5ak8.fsf@devron.myhome.or.jp> <4190EED2.5040906@lsrfire.ath.cx>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 02:25:28 +0900
In-Reply-To: <4190EED2.5040906@lsrfire.ath.cx> =?iso-8859-1?q?=28Ren=E9?= Scharfe's message of "Tue, 09 Nov 2004 17:22:42 +0100")
Message-ID: <87is8fj5o7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> We want to make sure filenames don't contain '*', '?' etc.

No. For example, Shift-JIS has 0x815c. It's contains the '\' (0x5c),
but the 0x815c is a valid char for fatfs.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
