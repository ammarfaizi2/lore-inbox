Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317518AbSFEAwR>; Tue, 4 Jun 2002 20:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSFEAwQ>; Tue, 4 Jun 2002 20:52:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:1219 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317518AbSFEAwQ>; Tue, 4 Jun 2002 20:52:16 -0400
Date: Wed, 5 Jun 2002 02:52:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10-ac1: Hardcoded cpu_khz in powernow-k6.c
Message-ID: <Pine.NEB.4.44.0206050236260.9994-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

while reading through powernow-k6.c in 2.4.19-pre10-ac1 I found the
following that seems to be a bug:

  static unsigned long cpu_khz=350000;

Not every K6-2/3 runs at 350 MHz...


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



