Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVEQQi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVEQQi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEQQi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:38:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:42178 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261795AbVEQQix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:38:53 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, dino@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517155731.GA9590@gmail.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave>  <20050517155731.GA9590@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 May 2005 11:38:34 -0500
Message-Id: <1116347914.4989.24.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 17:57 +0200, Grégoire Favre wrote:
> On this controler I have :
> 
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 15 Lun: 00
>   Vendor: SEAGATE  Model: ST336706LW       Rev: 0108
>   Type:   Direct-Access                    ANSI SCSI revision: 03

Erm, that doesn't square with the bug report:

>   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[...]
>   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi0:A:1:0: Tagged Queuing enabled.  Depth 32

James

