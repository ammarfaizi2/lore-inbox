Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbTCKU2U>; Tue, 11 Mar 2003 15:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261592AbTCKU2U>; Tue, 11 Mar 2003 15:28:20 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:64246 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261590AbTCKU2T>; Tue, 11 Mar 2003 15:28:19 -0500
Date: Tue, 11 Mar 2003 15:38:59 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: greg@snapgear.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include stddef.h in include/linux/list.h
Message-ID: <20030311153859.A17036@redhat.com>
References: <200303111907.h2BJ72502778@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303111907.h2BJ72502778@hera.kernel.org>; from linux-kernel@vger.kernel.org on Tue, Mar 11, 2003 at 05:47:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 05:47:54PM +0000, Linux Kernel Mailing List wrote:
> diff -Nru a/include/linux/list.h b/include/linux/list.h
> --- a/include/linux/list.h	Tue Mar 11 11:07:05 2003
> +++ b/include/linux/list.h	Tue Mar 11 11:07:05 2003
> @@ -3,6 +3,7 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/stddef.h>
>  #include <linux/prefetch.h>
>  #include <linux/stddef.h>
>  #include <asm/system.h>

Huh?  Surely you meant to delete the extra stddef.h include...

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
