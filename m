Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSHFUbH>; Tue, 6 Aug 2002 16:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSHFUbH>; Tue, 6 Aug 2002 16:31:07 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:25756 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315503AbSHFUbH>;
	Tue, 6 Aug 2002 16:31:07 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208062034.AAA25662@sex.inr.ac.ru>
Subject: Re: "new style" netdevice allocation patch for TUN driver
To: maxk@qualcomm.COM (Maksim (Max) Krasnyanskiy)
Date: Wed, 7 Aug 2002 00:34:26 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I completely agree. However sleeping and holding a lock that you
> don't have to hold

Nope. We have to hold it. Lock are taken to be held. :-)

Anyway, if you found real problem, it would be better if
you explained what is this, instead of proposing some random hacks.

Alexey
