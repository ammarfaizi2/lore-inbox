Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWH2Itk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWH2Itk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWH2Itk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:49:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:15593 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750834AbWH2Itj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:49:39 -0400
Date: Tue, 29 Aug 2006 10:48:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?UTF-8?B?TGltZW5nIFvmnY7okIxd?= <avlimeng@kingsoft.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: help
In-Reply-To: <004a01c6cb42$dbdbc110$8940a8c0@liibook>
Message-ID: <Pine.LNX.4.61.0608291046440.6963@yvahk01.tjqt.qr>
References: <004a01c6cb42$dbdbc110$8940a8c0@liibook>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-461829666-1156841319=:6963"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-461829666-1156841319=:6963
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>Hi,
>    How can I get one thread’s  LWP id on linux？ 
>    The thread is not the main thread, so that getpid() does not work. 
>And the LWP id is not the same as the result by pthread_self().
>
>    Any suggestion?

gettid(), I assume.



Jan Engelhardt
-- 
--1283855629-461829666-1156841319=:6963--
