Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRD1NeJ>; Sat, 28 Apr 2001 09:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRD1NeB>; Sat, 28 Apr 2001 09:34:01 -0400
Received: from quechua.inka.de ([212.227.14.2]:24122 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132511AbRD1NdJ>;
	Sat, 28 Apr 2001 09:33:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0104270953280.2067-100000@penguin.transmeta.com> <3AE9A69B.D11F0BBD@evision-ventures.com>
Organization: private Linux site, southern Germany
Date: Sat, 28 Apr 2001 15:20:40 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14tUeP-0000Vt-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> or such. tar/cpio and friends don't deal properly with
> a. holes inside of files.
> b. hardlinks between files.

GNU tar handles both of these. (Not particularly efficiently in the
case of sparse files, but that's a minor issue in this case.) See -S flag.

Perhaps more importantly, for a _robust_ backup solution which can
deal with partially unreadable tapes, you have pretty much no option
other than tar for the actual storage.

Olaf
