Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLaUsg>; Tue, 31 Dec 2002 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSLaUsg>; Tue, 31 Dec 2002 15:48:36 -0500
Received: from mx2.mail.ru ([194.67.57.12]:35589 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id <S264739AbSLaUsf>;
	Tue, 31 Dec 2002 15:48:35 -0500
Date: Tue, 31 Dec 2002 21:51:39 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi CD-recorder error reading burned disks
Message-ID: <Pine.LNX.4.44.0212312145020.3542-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After burning a CD, when trying to read I am getting the following
behaviour:

~> dd if=/dev/cdr of=/dev/null bs=2048
dd: reading `/dev/cdr': Input/output error
176996+0 records in
176996+0 records out

Whereas, the same disk read on the same drive under the normal ide-driver
works ok:

~> dd if=/dev/hdc of=/dev/null bs=2048
177039+0 records in
177039+0 records out

Other disks can be read on this drive also under ide-scsi ok, as well as
this disk can be read on a SCSI DVD-drive fine. Is it a known behaviour,
or a problem in the drive / driver?

2.4.20, drive is Benq CRW 4012A

Thanks
Guennadi



