Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264703AbSJOU2Z>; Tue, 15 Oct 2002 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSJOU2Z>; Tue, 15 Oct 2002 16:28:25 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264703AbSJOU2Y>;
	Tue, 15 Oct 2002 16:28:24 -0400
Date: Tue, 15 Oct 2002 13:34:23 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015203423.GI15864@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC6C7B.1080205@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:28:59PM -0700, Steven Dake wrote:
> 
> 
> Safte polling in the kernel isn't inherently bad and could be tied into 
> the hotplug mechanism.
> 
> Making SAFTE hotswap available via SG would also work but system 
> performance would be bad at small poll intervals (like 100 msec).

Is there a real nead to get hotplug notification any faster than that?

And yes, it should all be done in userspace, whenever possible :)

thanks,

greg k-h
