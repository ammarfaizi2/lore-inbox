Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319327AbSH2Tnq>; Thu, 29 Aug 2002 15:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319328AbSH2Tnq>; Thu, 29 Aug 2002 15:43:46 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24079
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319327AbSH2Tnp>; Thu, 29 Aug 2002 15:43:45 -0400
Date: Thu, 29 Aug 2002 12:46:02 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: /pub/linux/kernel/people/hedrick/ide-2.5.32
Message-ID: <Pine.LNX.4.10.10208291240560.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stuff has arrived.


ide-viro-2.5.32.patch
ide-lad-2.5.32.patch

	ide-all-2.5.32.patch == ide-viro-2.5.32.patch + ide-lad-2.5.32.patch

ide-taskfile-2.5.32.patch
scsi-st-2.5.32.patch

There is one more thing to fix.

./fs/mpage.c

/*
 * The largest-sized BIO which this code will assemble, in bytes.  Set this
 * to PAGE_CACHE_SIZE if your drivers are broken.
 */
#define MPAGE_BIO_MAX_SIZE 32768        //BIO_MAX_SIZE

This is confirmed with Al Viro and was required to make things sane!

We are back.
We is a development team being composed to reduce my load and import fresh
ideas.  If you wnat to help please join in, we can make the halloween
party.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

