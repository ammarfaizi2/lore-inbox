Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbTGEN0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbTGEN0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 09:26:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55709
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266349AbTGEN0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 09:26:24 -0400
Subject: Re: [PATCH 2.5.74, 2.5.74-mjb1] i2o compile fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307051311.19491.fsdeveloper@yahoo.de>
References: <200307051311.19491.fsdeveloper@yahoo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057412285.23520.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jul 2003 14:38:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-05 at 12:11, Michael Buesch wrote:
> This patch is tested to apply to 2.5.74 and 2.5.74-mjb1
> 
> - --- drivers/message/i2o/i2o_scsi.c.orig	2003-07-05 13:00:07.000000000 +0200
> +++ drivers/message/i2o/i2o_scsi.c	2003-07-05 13:02:59.000000000 +0200
> @@ -53,6 +53,7 @@
>  #include <asm/system.h>
>  #include <asm/io.h>
>  #include <asm/atomic.h>
> +#include <linux/pci.h>
>  #include <linux/blk.h>
>  #include <linux/i2o.h>
>  #include "../../scsi/scsi.h"

Looks fine to me.

