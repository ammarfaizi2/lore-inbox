Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGGRIp>; Sun, 7 Jul 2002 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGGRIo>; Sun, 7 Jul 2002 13:08:44 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:50077 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316187AbSGGRIo>;
	Sun, 7 Jul 2002 13:08:44 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207071709.VAA17085@sex.inr.ac.ru>
Subject: Re: [PATCH] simplify networking fcntl
To: willy@debian.ORG (Matthew Wilcox)
Date: Sun, 7 Jul 2002 21:09:02 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020707171555.L27706@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Jul 7, 2 08:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> sock_no_fcntl is only called for F_SETOWN, so it can stand some
> simplification.

sk->proc. Sorry, generic F_SETOWN does not handle SIGURG.

Alexey

