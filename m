Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSI3Rtq>; Mon, 30 Sep 2002 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbSI3Rtq>; Mon, 30 Sep 2002 13:49:46 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:62468 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262679AbSI3Rtq>;
	Mon, 30 Sep 2002 13:49:46 -0400
Message-Id: <200209301858.NAA03537@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML highmem support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Sep 2002 13:58:29 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org:5000/highmem-2.5

This adds the UML arch support for highmem.  All changes are in arch code.

				Jeff

ChangeSet@1.579.13.5, 2002-09-29 22:18:25-04:00, jdike@uml.karaya.com
  Added CONFIG_HIGHMEM to defconfig.

ChangeSet@1.579.13.4, 2002-09-29 22:02:45-04:00, jdike@uml.karaya.com
  One last fix to make the non-highmem build work.

ChangeSet@1.579.13.3, 2002-09-28 15:45:58-04:00, jdike@uml.karaya.com
  Missed a change to fixmap.h in the highmem update.

ChangeSet@1.579.13.2, 2002-09-28 15:31:57-04:00, jdike@uml.karaya.com
  Fixed highmem support for 2.5.

ChangeSet@1.579.13.1, 2002-09-23 21:43:15-04:00, jdike@uml.karaya.com
  Added highmem support.
  The UML initialization code marks memory that doesn't fit in the
  kernel's address space as highmem, and later sets up the UML data
  structures for it, and frees that memory to the mm system as highmem.

