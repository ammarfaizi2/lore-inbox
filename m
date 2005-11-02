Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVKBIHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVKBIHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVKBIHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:07:16 -0500
Received: from pat.qlogic.com ([198.70.193.2]:18952 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S932637AbVKBIHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:07:15 -0500
Date: Wed, 2 Nov 2005 00:07:11 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       support@qlogic.com, akpm@osdl.org, stable@kernel.org
Subject: Re: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device Driver
Message-ID: <20051102080711.GB626@plapn>
References: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com>
Organization: QLogic Corporation
X-Operating-System: Darwin 8.2.0 powerpc
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Nov 2005 08:07:14.0097 (UTC) FILETIME=[6F017210:01C5DF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2005, Ashutosh Naik wrote:

> This patch fixes the fact that although the scsi_transport_fc.h header
> file is not included in qla_def.h, we still reference the function
> fc_remote_port_unlock in the qlogic  ISP2x00 device driver ,
> qla2xxx/qla_rscn.c

Perhaps for the stable tree (2.6.14.x) this fix is appropriate.  The
scsi-misc-2.6.git tree already has codes which address this issue.

Regards,
Andrew Vasquez
