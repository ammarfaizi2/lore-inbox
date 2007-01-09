Return-Path: <linux-kernel-owner+w=401wt.eu-S1751309AbXAIKmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbXAIKmL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbXAIKmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:42:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33605 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXAIKmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:09 -0500
Message-ID: <45A3717E.1060603@pobox.com>
Date: Tue, 09 Jan 2007 05:42:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ata/: make 4 functions static
References: <20070103230936.GR20714@stusta.de>
In-Reply-To: <20070103230936.GR20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes the following needlessly global functions static:
> - libata-core.c: ata_qc_complete_internal()
> - libata-scsi.c: ata_scsi_qc_new()
> - libata-scsi.c: ata_dump_status()
> - libata-scsi.c: ata_to_sense_error()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied


