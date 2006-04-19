Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWDSTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDSTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWDSTdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:33:16 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:18080 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751152AbWDSTdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:33:15 -0400
Subject: Re: [-mm patch] drivers/scsi/aic7xxx/: possible cleanups
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Denis Vlasenko <vda@ilport.com.ua>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060418221423.GW11582@stusta.de>
References: <20060418031423.3cbef2f7.akpm@osdl.org>
	 <20060418221423.GW11582@stusta.de>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 14:31:43 -0500
Message-Id: <1145475103.3460.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 00:14 +0200, Adrian Bunk wrote:
> This patch contains cleanups including the following:
> - make nedlessly global functions static
> - #if 0 the following unused global functions:
>   - aic7xxx_core.c: ahc_inq()
>   - aic7xxx_core.c: ahc_outq()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I'll make you the same offer I made Denis Vlasenko:  convert this driver
to use ioremap_port and ioread8/iowrite8 and I'll happily put in and
test your cleanup patches.

James


