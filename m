Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTAOKRx>; Wed, 15 Jan 2003 05:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTAOKRx>; Wed, 15 Jan 2003 05:17:53 -0500
Received: from [81.2.122.30] ([81.2.122.30]:7429 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266116AbTAOKRw>;
	Wed, 15 Jan 2003 05:17:52 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301151026.h0FAQv2R000864@darkstar.example.net>
Subject: Re: Kernel patch
To: ednei_gp@yahoo.com.br (=?iso-8859-1?q?ednei=5Fgp?=)
Date: Wed, 15 Jan 2003 10:26:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030115101133.10886.qmail@web21006.mail.yahoo.com> from "=?iso-8859-1?q?ednei=5Fgp?=" at Jan 15, 2003 07:11:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm testing the devel kernel 2.5.52 but I've a problem
> if framebuffer , so I'll use a patch to uptade my
> kernel but I'dont know if to me use the patch 2.5.58 I
> need to install the other patchs before, like patch
> 2.5.53,2.5.54,2.5.55...

Yes, you need to apply each patch, using:

bzip2 -dc patch-2.5.53.bz2 | patch -p1

and you can test them first using:

bzip2 -dc patch-2.5.53.bz2 | patch -p1 --dry-run

> Because if I'll need do this I'll download the last
> version than use all that patchs...

Note - if 2.5.58 doesn't work, you can always download patch-2.5.58,
and apply it with:

bzip2 -dc patch-2.5.58.bz2 | patch -p1 -R

to create a 2.5.57 tree, even if you didn't go from 2.5.57 to 2.5.58
by using a patch.

John.
