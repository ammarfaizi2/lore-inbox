Return-Path: <linux-kernel-owner+w=401wt.eu-S1030321AbWLTTVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWLTTVv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWLTTVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:21:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34974 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030321AbWLTTVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:21:47 -0500
Message-ID: <45898D48.8020800@pobox.com>
Date: Wed, 20 Dec 2006 14:21:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Milburn <dmilburn@redhat.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers
 from sense data
References: <458702D9.6080800@redhat.com>
In-Reply-To: <458702D9.6080800@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Milburn wrote:
> User applications using the HDIO_DRIVE_TASK ioctl through libata
> expect specific ATA registers to be returned to userspace. Verified
> that ata_task_ioctl correctly returns register values to the
> smartctl application.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

ACK, but fails to apply to libata-dev.git#upstream-fixes:


[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
1 patch(es) to process.

Applying 'libata-scsi: ata_task_ioctl should return ATA registers from 
sense data'

fatal: corrupt patch at line 83

