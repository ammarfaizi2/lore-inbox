Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUHWW3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUHWW3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUHWVgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:36:55 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:24335 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S266519AbUHWV3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:29:15 -0400
Date: Mon, 23 Aug 2004 16:28:37 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: patch for kernel_stats.h, bumps DK_MAX_MAJOR to 111
Message-ID: <20040823212837.GB8811@beardog.cca.cpqcorp.net>
References: <20040823212517.7FBD34FF36@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823212517.7FBD34FF36@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 04:25:17PM -0500, Mail Delivery System wrote:
> 
> Final-Recipient: rfc822; axboe.suse.de@beardog.cca.cpqcorp.net
> Action: failed
> Status: 5.0.0
> Diagnostic-Code: X-Postfix; unknown user: "axboe.suse.de"

Content-Description: Undelivered Message
> Date: Mon, 23 Aug 2004 16:25:17 -0500
> From: mikem <mikem@beardog.cca.cpqcorp.net>
> To: marcelo.tossati@cyclades.com, axboe.suse.de@beardog.cca.cpqcorp.net
> Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
> Subject: patch for kernel_stats.h, bump DK_MAJOR_MAX for cciss devices
> User-Agent: Mutt/1.5.6i

Sorry Jens,
I messed up your email address in my first send.

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

