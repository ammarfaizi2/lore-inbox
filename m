Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVKPIvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVKPIvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVKPIvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:51:44 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:39868 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1030238AbVKPIvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:51:43 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel crash report in SCSI over USB with kernel 2.6.14
Date: Wed, 16 Nov 2005 08:45:41 GMT
Message-ID: <05GFF0511@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is stock Linux 2.6.14, SMP, with 6 USB disks and no real SCSI hardware.

The kernel stack crash report is:
scsi_end_request +0xaf/0xc0 [scsi_mod]
scsi_io_completion
scsi_finish_commands
scsi_softirg
__rcu_process_callblacks
ksoftirqd
ksoftirqd
kthread
kthread
kernel_thread_helper

