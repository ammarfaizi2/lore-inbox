Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTGASjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGASi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:38:57 -0400
Received: from ns.mock.com ([209.157.146.194]:52678 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S263354AbTGASgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:36:50 -0400
Message-Id: <5.1.0.14.2.20030701114153.060dd098@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 01 Jul 2003 11:51:09 -0700
To: Jeff Garzik <jgarzik@pobox.com>
From: Jeff Mock <jeff-ml@mock.com>
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F007AC4.9040304@pobox.com>
References: <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
 <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1035; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:00 PM 6/30/2003 -0400, Jeff Garzik wrote:
>Jeff Mock wrote:
>>I tried 2.4.21-ac4 to see if there were any ICH5-SATA related
>>changes.  2.4.21-ac4 does not seem to find the ICH5-SATA controller
>>or probe the SATA drives, (problems with ICH5-SATA on 2.4.21 are
>>described below).
>>Does anyone know what's up with SATA support on ICH5?
>
>
>Enable CONFIG_SCSI_ATA and CONFIG_SCSI_ATA_PIIX...
>
>         Jeff
>


Thanks, I see.  With -ac4 it looks like there is a new SATA
driver and the SATA devices appear as /dev/scdn.

With this new change does the BIOS (on an Intel 875P / ICH5
motherboard) still need the drives to be set to legacy mode, or can
it be set to enhanced mode to access the full complement of SATA
and PATA devices?

jeff



