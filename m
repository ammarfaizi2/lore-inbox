Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTBEXnQ>; Wed, 5 Feb 2003 18:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBEXnQ>; Wed, 5 Feb 2003 18:43:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9232 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265168AbTBEXnP>;
	Wed, 5 Feb 2003 18:43:15 -0500
Date: Wed, 5 Feb 2003 15:48:29 -0800
From: Greg KH <greg@kroah.com>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
Message-ID: <20030205234829.GB22101@kroah.com>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 05:13:53PM -0800, Andy Chou wrote:
> 7	|	drivers/hotplug/cpqphp_nvram.c

These were all real problems (and you missed one at the end, there was
two places bus_node could be leaked like the other ones) and I've fixed
them in my trees.

thanks,

greg k-h
