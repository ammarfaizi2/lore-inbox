Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTD3Lhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTD3Lhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 07:37:50 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262100AbTD3Lht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 07:37:49 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304301154.h3UBs0ob000471@81-2-122-30.bradfords.org.uk>
Subject: Bootable CD idea
To: linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2003 12:54:00 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a random idea that occurred to me...

Since the El-Torito bootable CD standard supports multiple floppy
images on a single CD, it would be possible to write a script that
takes a .config file, and the source to, say all the -pre and -rc
versions of a particular kernel, compiles multiple kernels with the
same .config, and writes a CD with them all on, set to boot from an
arbitrary disk partition.

It would make:

> > > Foo doesn't work in -rc2
> > Did it work in -rc1
> Not sure

E-Mail exchanges a thing of the past.

Note, that as each floppy image is separate, it's not the same as
trying to cram multiple kernels on a 2.88 MB floppy image, and is
therefore actually do-able :-).

John.
