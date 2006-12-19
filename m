Return-Path: <linux-kernel-owner+w=401wt.eu-S932232AbWLSH3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWLSH3p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWLSH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:29:45 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:44300 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbWLSH3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:29:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=XGJDNmU4+sI2WRT1058b5WJiPvRETZkmNGe2sW4BeZDbr/ExOs4/BNSQ+M6aH44hV4fllkWurc4AvQ9SOdJMuLIhX9czO9iwws2djEBCMqNRlGtdp1A/K4KR56qtXDdG5m/OJVtcBhV3DOKOMef8U4n/H7i4qNvmzlDGI2jmDqE=
Message-ID: <458794DF.8070100@gmail.com>
Date: Tue, 19 Dec 2006 16:29:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: David Milburn <dmilburn@redhat.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers
 from sense data
References: <458702D9.6080800@redhat.com>
In-Reply-To: <458702D9.6080800@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Milburn wrote:
> User applications using the HDIO_DRIVE_TASK ioctl through libata
> expect specific ATA registers to be returned to userspace. Verified
> that ata_task_ioctl correctly returns register values to the
> smartctl application.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
