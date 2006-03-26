Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWCZTcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWCZTcK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCZTcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:32:10 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:40965 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751465AbWCZTcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:32:09 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Sun, 26 Mar 2006 14:29:59 -0500
To: Linda Walsh <lkml@tlinx.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16?
Message-ID: <20060326192958.GA4864@voodoo>
Mail-Followup-To: Linda Walsh <lkml@tlinx.org>,
	Adrian Bunk <bunk@stusta.de>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <44237D87.70300@tlinx.org> <20060325192635.GQ4053@stusta.de> <4426620C.2040707@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4426620C.2040707@tlinx.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/06 01:42:36AM -0800, Linda Walsh wrote:
> Adrian Bunk wrote:
> >- hotplugging devices != module loading
> >- CONFIG_HOTPLUG does not load any code into the kernel.
> >- hotplugging devices can work without any userspace support
> >
> >As an example, hotplugging an USB hard disk works fine with 
> >CONFIG_MODULES=n and without any userspace support (assuming
> >a static /dev).
> >  
> ---
>    Ah, I see.   But if I have no USB hard disk to plug in?
> Should I still be compiling in HOTPLUG?  Seems a waste.
> Thanks for the example though...
> 
> -linda

But what about USB keyboards and mice? IIRC at least some of the newer
servers where I work don't come with PS/2 ports anymore.

Jim.
