Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCOPVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCOPVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVCOPVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:21:13 -0500
Received: from mail0.lsil.com ([147.145.40.20]:16031 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261290AbVCOPVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:21:07 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC3D@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Adrian Bunk'" <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: 2.6.11-mm3: megaraid_sas.c: stack usage
Date: Tue, 15 Mar 2005 10:13:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
>>...
>> All 606 patches:
>>...
>> megaraid_sas-announcing-new-module-for.patch
>>   megaraid_sas: Announcing new module for LSI Logic's SAS 
>based MegaRAID controllers
>>...
>
>Enormous stack usage:
>- megasas_init_mfi (due to ctrl_info)
>
>Big stack usage:
>- megasas_mgmt_ioctl (due to uioc and dv)
>- megasas_mgmt_fw_ioctl (due to uioc)
>
>Please fix this.
> 

Will do.

Thanks,
Sreenivas
LSI Logic Corporation
