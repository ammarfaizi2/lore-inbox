Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSJJE4w>; Thu, 10 Oct 2002 00:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbSJJE4w>; Thu, 10 Oct 2002 00:56:52 -0400
Received: from [64.76.155.18] ([64.76.155.18]:51132 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S262023AbSJJE4v>;
	Thu, 10 Oct 2002 00:56:51 -0400
Date: Thu, 10 Oct 2002 01:02:34 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
Subject: make allmodconfig broken in 2.5.41?
Message-ID: <Pine.LNX.4.44.0210100100240.19850-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

drivers/scsi/53c700.c:162:22: 53c700_d.h: No such file or directory
make -f drivers/scsi/aacraid/Makefile fastdep
/home/rmaureira/kj/2.5/linux-2.5.41/Rules.make:15: *** kbuild: 
drivers/scsi/aacraid/Makefile - Usage of O_TARGET := aacraid.o is obsolete 
in 2.5. Please fix!.  Stop.

after doing:

make allmodconfig
make dep

Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

