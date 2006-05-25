Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWEYRlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWEYRlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWEYRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:41:46 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:13789 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030297AbWEYRlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:41:45 -0400
Message-ID: <4475EC58.7020508@pardus.org.tr>
Date: Thu, 25 May 2006 20:41:44 +0300
From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
User-Agent: Mozilla Thunderbird 1.5.0.2 (X11/20060426)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qla1280: fix section mismatch warnings
References: <20060525103932.ca36a587.rdunlap@xenotime.net>
In-Reply-To: <20060525103932.ca36a587.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=5B88F54C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote On 25-05-2006 20:39:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix section mismatch warnings:
> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a16)
> and 'qla1280_probe_one'
> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a3c)
> and 'qla1280_probe_one'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/scsi/qla1280.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Ack, fixes the warning for me. Thanks Randy!

Regards,
ismail

