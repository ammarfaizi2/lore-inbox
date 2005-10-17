Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVJQSAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJQSAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJQSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:00:33 -0400
Received: from pat.qlogic.com ([198.70.193.2]:40028 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751286AbVJQSAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:00:32 -0400
Date: Mon, 17 Oct 2005 11:00:29 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix implicit declaration compile warning in qla2xxx
Message-ID: <20051017180029.GA9192@plap.qlogic.org>
References: <200510171959.23585.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510171959.23585.jesper.juhl@gmail.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 17 Oct 2005 18:00:31.0736 (UTC) FILETIME=[AA3E1780:01C5D344]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Jesper Juhl wrote:

> Fix warning about implicitly declared function in qla_rscn.c
>   drivers/scsi/qla2xxx/qla_rscn.c:334: warning: implicit declaration of function `fc_remote_port_unblock'
> 
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  drivers/scsi/qla2xxx/qla_rscn.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> --- linux-2.6.14-rc4-mm1-orig/drivers/scsi/qla2xxx/qla_rscn.c	2005-10-11 22:41:20.000000000 +0200
> +++ linux-2.6.14-rc4-mm1/drivers/scsi/qla2xxx/qla_rscn.c	2005-10-17 19:53:50.000000000 +0200
> @@ -17,6 +17,7 @@
>   *
>   */
>  #include "qla_def.h"
> +#include <scsi/scsi_transport_fc.h>
>  
>  /**
>   * IO descriptor handle definitions.
> 
> 


Sent earlier:

http://marc.theaimsgroup.com/?l=linux-scsi&m=112907350209822&w=2

Awaiting inclusion.


Thanks,
Andrew Vasquez
