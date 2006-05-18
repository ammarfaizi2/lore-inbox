Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWERDaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWERDaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 23:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWERDaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 23:30:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:48043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751202AbWERDaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 23:30:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lIQq4wbkZ3uKHKoOQS9zC4QC7ecfzwqvQSAp5PIepJ423OJMGrQlYHshtSWrPZOSuNKe3TazqNNZ2Tpu/3LCivELD44u4G/y1OWKVNYQgSuW3165MtE3O81b5TnUkWsNnlKTBCQNoafGFU5sH/GVCKT562u+xMnyeKJwvpeX78I=
Message-ID: <446BEA2E.3030100@gmail.com>
Date: Thu, 18 May 2006 12:29:50 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: albertl@mail.com, Andi Kleen <ak@suse.de>,
       Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDC15@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC15@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> scsi0 : sata_via
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
> ata2.00: ATAPI, max UDMA/66
> ata2.00: applying bridge limits
> ata2.00: configured for UDMA/66
[--snip--]
> sd 0:0:0:0: Attached scsi disk sda
>   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
>   Type:   CD-ROM                             ANSI SCSI revision: 05

Above and the detailed log too indicate that everything went smooth the 
first time around.  Albert, do you have any ideas?  Could it be 
something related to irq-pio?

-- 
tejun
