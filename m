Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317021AbSFFRJl>; Thu, 6 Jun 2002 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFFRJk>; Thu, 6 Jun 2002 13:09:40 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:63986 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S317021AbSFFRJi>;
	Thu, 6 Jun 2002 13:09:38 -0400
Date: Thu, 6 Jun 2002 13:09:35 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Robert Love <rml@tech9.net>
Cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
Message-ID: <20020606170935.GA32506@www.kroptech.com>
In-Reply-To: <3CFF3504.1DCD24E7@zip.com.au> <20020606.031520.08940800.davem@redhat.com> <1023377213.13787.2.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 08:26:52AM -0700, Robert Love wrote:
> I have attached a patch that is Andrew's + your request, Dave.  Since
> what really determines the maximum number of CPUs is the size of
> unsigned long, I used that.  Cool?
> 
> 	Robert Love
> 
> diff -urN linux-2.5.20/arch/i386/Config.help linux/arch/i386/Config.help
> --- linux-2.5.20/arch/i386/Config.help	Sun Jun  2 18:44:41 2002
> +++ linux/arch/i386/Config.help	Thu Jun  6 07:58:58 2002
> @@ -25,6 +25,14 @@
>  
>    If you don't know what to do here, say N.
>  
> +CONFIG_NR_CPUS
> +  This allows you to specify the maximum number of CPUs which this
> +  kernel will support.  The maximum supported value is 32 and the
                                                          ^^
This isn't quite true now...

--Adam

