Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbUCXPMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUCXPMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:12:45 -0500
Received: from [209.226.175.93] ([209.226.175.93]:17539 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263747AbUCXPM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:12:27 -0500
Message-ID: <4061A548.8060605@passport.ca>
Date: Wed, 24 Mar 2004 10:12:08 -0500
From: Jim Ruxton <cinetron@passport.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6..5-rc2 "make modules" fails in drivers/scsi/scsi_transport_spi.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi any thoughts what I can do to fix this? Thanks
A reply to me as well as the list would be appreciated.

LD [M] drivers/scsi/scsi_mod.o
CC [M] drivers/scsi/scsi_transport_spi.o
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_retrain':
drivers/scsi/scsi_transport_spi.c:388: parse error before `;'
drivers/scsi/scsi_transport_spi.c:392: parse error before `;'
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device_internal':
drivers/scsi/scsi_transport_spi.c:463: parse error before `;'
drivers/scsi/scsi_transport_spi.c:475: parse error before `;'
drivers/scsi/scsi_transport_spi.c:494: parse error before `;'
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device':
drivers/scsi/scsi_transport_spi.c:539: parse error before `;'
drivers/scsi/scsi_transport_spi.c:543: parse error before `;'
make[2]: *** [drivers/scsi/scsi_transport_spi.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

