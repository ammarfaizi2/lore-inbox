Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSE2SQP>; Wed, 29 May 2002 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSE2SQO>; Wed, 29 May 2002 14:16:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28297 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314459AbSE2SQN>;
	Wed, 29 May 2002 14:16:13 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 29 May 2002 20:16:12 +0200 (MEST)
Message-Id: <UTC200205291816.g4TIGCm15957.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com, gerald@io.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hdparm -i is executing the drive id command directly
> and does *not* rely on the internally permanently dragged around id structure.

The situation used to be that "hdparm -i" used the information read at boot time,
while "hdparm -I" read the current situation. That was sometimes useful.

Andries
