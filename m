Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVBXXRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVBXXRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVBXXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:17:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:60038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262539AbVBXXRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:17:36 -0500
Date: Thu, 24 Feb 2005 15:17:21 -0800
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-ID: <20050224231721.GA26697@kroah.com>
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <421D0582.9090100@free.fr> <20050223234720.GA7270@kroah.com> <421E099F.1030104@free.fr> <20050224171856.GB9439@kroah.com> <421E3C30.8080703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E3C30.8080703@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 09:42:24PM +0100, Laurent Riffard wrote:
> I do need device-mapper, since I put /usr and /var on LVM filesystems. I
> use ptkcdvd to copy data to CD-RW. I can remove this one.
> 
> Anyway, this patch from Andrew fixed the problem :
> http://lkml.org/lkml/2005/2/23/214.

Yeah, it's not in my code!  :)

> So I won't try to remove pktcdvd and device-mapper driver (except if you
> _really_ want me to do so).

Nope, as long as the above patch works for you, I'm happy.

thanks,

greg k-h
