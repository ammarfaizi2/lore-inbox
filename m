Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSD2CTW>; Sun, 28 Apr 2002 22:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314749AbSD2CTV>; Sun, 28 Apr 2002 22:19:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41726 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314748AbSD2CTV>;
	Sun, 28 Apr 2002 22:19:21 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Apr 2002 04:19:19 +0200 (MEST)
Message-Id: <UTC200204290219.g3T2JJU00528.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: IDE crashes 2.5.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a NULL dereference in ata_ar_put() in 2.5.10
(drive->tcq is NULL).

That was a vanilla 2.5.10. Some other version was
less friendly and wrote garbage over the start of
my root filesystem. Inconvenient.

Andries
