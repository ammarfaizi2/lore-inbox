Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTAHFDR>; Wed, 8 Jan 2003 00:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTAHFDR>; Wed, 8 Jan 2003 00:03:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40713 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267743AbTAHFDQ>;
	Wed, 8 Jan 2003 00:03:16 -0500
Date: Tue, 7 Jan 2003 21:11:34 -0800
From: Greg KH <greg@kroah.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH] [2.5] IRQ distribution in the 2.5.52  kernel
Message-ID: <20030108051134.GA32422@kroah.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE52@fmsmsx407.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE52@fmsmsx407.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 06:52:59PM -0800, Kamble, Nitin A wrote:
> +# define MIN(a,b) (((a) < (b)) ? (a) : (b))
> +# define MAX(a,b) (((a) > (b)) ? (a) : (b))

There are alread definitions for min() and max(), it would be good to
use them and not try to define your own.

thanks,

greg k-h
