Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966994AbWKVBWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966994AbWKVBWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966997AbWKVBWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:22:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:42133 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966994AbWKVBWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:22:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rbbKLSI3LdgxvM0pCgUjowZJ9ecnJwBWoRdJ5cvjz+vHNKEGFCHD1WiaqKC69YB3M4YnA6nC2zL7gilInX6W+OWyDPzPqR9A1GZbQAhKG6zosxtbXFaSXQedoXSgtKNEusEyMCsZTLYIJLEYrzqDDTAVX6zAKXVexemLojpZoTY=
Message-ID: <4563A661.3070908@gmail.com>
Date: Wed, 22 Nov 2006 10:22:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for
 Intel ICH9
References: <200611211653.51596.jason.d.gaston@intel.com>
In-Reply-To: <200611211653.51596.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20 04:58:48.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20 06:15:12.000000000 -0800

Yeap, it came through fine this time, but ich8 and ich9 are identical 
from ata_piix's point of view.  Don't add ich9_sata_ahci, just use 
ich8_sata_ahci.

-- 
tejun
