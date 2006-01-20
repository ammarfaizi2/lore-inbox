Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWATXTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWATXTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWATXTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:19:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:7814 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751189AbWATXTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:19:14 -0500
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
	approach
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org,
       Ben Collins <ben.collins@ubuntu.com>
In-Reply-To: <20060120212917.GA14405@suse.de>
References: <20060119174600.GT19398@stusta.de>
	 <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
	 <20060120212917.GA14405@suse.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 10:16:40 +1100
Message-Id: <1137799001.12998.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
>  On Fri, Jan 20, Adrian Bunk wrote:
> 
>  
> > Can someone from the ppc developers drop me a small note whether 
> > SND_POWERMAC completely replaces DMASOUND_PMAC?
> 
> It doesnt. Some tumbler models work only after one plug/unplug cycle of
> the headphone. early powerbooks report/handle the mute settings
> incorrectly. there are likely more bugs.

Interesting... Ben Collins hacked something to have Toonie work as a
"default" driver for non supported machine and saw that problem too, I
think he fixes it, I'll check with him what's up there and if his fix
applied to tumbler.c as well.

Ben.


