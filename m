Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbSKDKlG>; Mon, 4 Nov 2002 05:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSKDKlG>; Mon, 4 Nov 2002 05:41:06 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:17810 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264637AbSKDKlF>; Mon, 4 Nov 2002 05:41:05 -0500
Subject: RE: [announce] swap mini-howto
From: Richard Russon <ntfs@flatcap.org>
To: Troels Walsted Hansen <troels@thule.no>
Cc: lkml <linux-kernel@vger.kernel.org>, Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <003401c28262$2d280ac0$0300000a@samurai>
References: <003401c28262$2d280ac0$0300000a@samurai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 10:47:33 +0000
Message-Id: <1036406853.29035.78.camel@whiskey.something.uk.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Troels,

> Does anyone know if NTFS-TNG in 2.5 is robust enough to mount Windows XP
> partitions and allow overwriting of existing files such as pagefile.sys?

Yes, this shouldn't be a problem.

Anton has successfully tested overwriting normal files (not compressed,
sparse or encrypted).  This is possible with either write or mmap.

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org



