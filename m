Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282781AbRLVWP1>; Sat, 22 Dec 2001 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282838AbRLVWPO>; Sat, 22 Dec 2001 17:15:14 -0500
Received: from gzp.hu ([212.184.222.124]:2057 "EHLO gzp11.gzp")
	by vger.kernel.org with ESMTP id <S282781AbRLVWO6>;
	Sat, 22 Dec 2001 17:14:58 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: devfs permissions
In-Reply-To: <20011207084910.7ec3b9c3.rene.rebe@gmx.net> <20011207003528.1448673e.rene.rebe@gmx.net> <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca> <20011207084910.7ec3b9c3.rene.rebe@gmx.net> <200112071641.fB7GfpS14840@vindaloo.ras.ucalgary.ca>
Organization: gzp
Message-ID: <27e4.3c2505d3.14a5@gzp1.gzp>
Date: Sat, 22 Dec 2001 22:14:42 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard Gooch <rgooch@ras.ucalgary.ca>:

|> (which worked before but won't any more) do:
|>     REGISTER ^sound/.* PERMISSIONS root.audio 0664
|> or something similar.

And what about subdirs, like in case of /dev/ide/...

	REGISTER ^ide/.* PERMISSIONS root.disk 0660

sets the permission 0660 on /dev/ide/host0/ also.

