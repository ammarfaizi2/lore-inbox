Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbTCKUEF>; Tue, 11 Mar 2003 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbTCKUEF>; Tue, 11 Mar 2003 15:04:05 -0500
Received: from mail0.ewetel.de ([212.6.122.10]:42641 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id <S261573AbTCKUEE>;
	Tue, 11 Mar 2003 15:04:04 -0500
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved inode number allocation for HTree
In-Reply-To: <20030311194014$49a6@gated-at.bofh.it>
References: <20030311194014$426e@gated-at.bofh.it> <20030311194014$1a3c@gated-at.bofh.it> <20030311194014$78c3@gated-at.bofh.it> <20030311194014$5811@gated-at.bofh.it> <20030311194014$49a6@gated-at.bofh.it>
Date: Tue, 11 Mar 2003 21:14:38 +0100
Message-Id: <E18sq90-0002uC-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003 20:40:14 +0100, you wrote in linux.kernel:

> Ok, so "rm" works.  Then you have things like "mv *.c /usr/src" to worry
> about.  Lock for traversal, get stuck unable to work on the files.

In both cases, the shell does the traversal and passes a complete list
of files to rm or mv... so rm and mv themselves don't need to do any
directory traversal.

-- 
Ciao,
Pascal
