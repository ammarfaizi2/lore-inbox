Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUAMJD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUAMJD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:03:57 -0500
Received: from winniepooh.iatp.festu.ru ([80.89.5.238]:64726 "EHLO
	iatp.festu.ru") by vger.kernel.org with ESMTP id S263173AbUAMJDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:03:55 -0500
Date: Tue, 13 Jan 2004 19:03:44 +1000
From: Little Djo <hatred@iatp.festu.ru>
To: linux-kernel@vger.kernel.org
Subject: Two CDROM drives and module compilation of CDROM Support
Message-Id: <20040113190344.466e2a7d.hatred@iatp.festu.ru>
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I build CDROM support as module, then work only first CDROM (hdc):
[root]# modprobe ide-cd
[root]# dmesg | tail -3
ide-cd: ignoring drive hdd
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

if i compile CDROM support in kernel, all two drives work!

this feature present in kernel 2.6.0 (-test## also), 2.6.1, 2.6.1-mm1,
but don't present in kernel 2.4.x

-- 
Удачи,                                            Hatred

:: Linux team :: FREE OS for FREE people :: VLUG team ::
   http://linux.pk.ru, http://iatp.festu.ru/~hatred
        hatred@iatp.festu.ru, h4tr3d@yandex.ru
