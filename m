Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCZDcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCZDcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVCZDcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:32:15 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:8108 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261921AbVCZDcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:32:12 -0500
Subject: Re: [PATCH 1/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <91888D455306F94EBD4D168954A9457C01B70560@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C01B70560@nacos172.co.lsil.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 21:32:03 -0600
Message-Id: <1111807923.5541.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 16:56 -0700, Moore, Eric Dean wrote:
> +
>  config FUSION_FC
> -       tristate "Fusion MPT (base + ScsiHost) drivers for FC"
> -       depends on PCI && SCSI
> +       tristate "Fusion MPT (ScsiHost) drivers for FC"

This rejects completely in Kconfig.  Could you check your base for the
diffs ... there's no FUSION_FC parameter in the vanilla kernel.

Thanks,

James


