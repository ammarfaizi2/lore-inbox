Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUHWVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUHWVlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUHWVkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:40:11 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:40201 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268101AbUHWVep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:34:45 -0400
Date: Mon, 23 Aug 2004 16:34:08 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@Cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: patch to kernel_stats.h, bumps DK_MAX_MAJOR for cciss
Message-ID: <20040823213408.GC8811@beardog.cca.cpqcorp.net>
References: <20040823212517.GA8811@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823212517.GA8811@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 04:25:17PM -0500, Postmaster@Cyclades.com wrote:
> From: mikem <mikem@beardog.cca.cpqcorp.net>
> To: marcelo.tossati@cyclades.com, axboe.suse.de@beardog.cca.cpqcorp.net
> Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
> Subject: patch for kernel_stats.h, bump DK_MAJOR_MAX for cciss devices
> User-Agent: Mutt/1.5.6i
> X-Cyclades-MailScanner-Information: Please contact the ISP for more information
> X-Cyclades-MailScanner: Found to be clean
> X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release 6.5.1|January 21, 2004) at
>  08/23/2004 14:27:21,
> 	Serialize by Router on USMail/Cyclades(Release 6.5.1|January 21, 2004) at
>  08/23/2004 14:27:22,
> 	Serialize complete at 08/23/2004 14:27:22

Sorry, Marcelo, I butchered your name also.

mikem

> 
> This patch bumps DK_MAX_MAJOR to 111 so various cciss statistics can be
> collected just they are with SCSI, IDE, etc.
> Applies to 2.4.28-pre1. Please consider this for inclusion.
> 
> Thanks,
> mikem
> -------------------------------------------------------------------------------
> diff -burNp lx2428-pre1.orig/include/linux/kernel_stat.h lx2428-pre1/include/linux/kernel_stat.h
> --- lx2428-pre1.orig/include/linux/kernel_stat.h	2004-08-23 15:41:43.640300000 -0500
> +++ lx2428-pre1/include/linux/kernel_stat.h	2004-08-23 15:43:07.097613064 -0500
> @@ -12,7 +12,7 @@
>   * used by rstatd/perfmeter
>   */
>  
> -#define DK_MAX_MAJOR 16
> +#define DK_MAX_MAJOR 111
>  #define DK_MAX_DISK 16
>  
>  struct kernel_stat {

