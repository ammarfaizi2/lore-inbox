Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRBDSAw>; Sun, 4 Feb 2001 13:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132157AbRBDSAm>; Sun, 4 Feb 2001 13:00:42 -0500
Received: from quechua.inka.de ([212.227.14.2]:15724 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132139AbRBDSAc>;
	Sun, 4 Feb 2001 13:00:32 -0500
From: W1012@lina.inka.de
To: linux-kernel@vger.kernel.org
Subject: Re: accept
Message-Id: <E14PTSg-00018o-00@sites.inka.de>
Date: Sun, 4 Feb 2001 19:00:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01020411401700.00110@grndctrl> you wrote:
> Ok, but fd 0 cant be a valid socket since its the stdin
if you have closed stdin (like all daemons usually do) you will get fd 0 on
next open. There is nothing magical about fd0 or fd1.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
