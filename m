Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSAIQ24>; Wed, 9 Jan 2002 11:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSAIQ2i>; Wed, 9 Jan 2002 11:28:38 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:8208 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287828AbSAIQ2Y>;
	Wed, 9 Jan 2002 11:28:24 -0500
Date: Wed, 9 Jan 2002 08:26:07 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Anton Altaparmakov <aia21@cam.ac.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109162606.GB20572@kroah.com>
In-Reply-To: <20020109155608.GG21317@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 14:23:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 08:04:44AM -0800, Patrick Mochel wrote:
> 
> Will we need cardmgr in the future, or will be able to get away with
> /sbin/hotplug?

Hopefully only /sbin/hotplug if the pcmcia port to the kernel is ever
finished (some people were working on it.)  If not, then we will need
cardmgr for some cards.

greg k-h
