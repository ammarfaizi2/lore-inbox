Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWASDPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWASDPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWASDPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:15:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:24770 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161189AbWASDPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:15:33 -0500
Date: Wed, 18 Jan 2006 19:14:55 -0800
From: Greg KH <greg@kroah.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG in tmpfs
Message-ID: <20060119031455.GA15738@kroah.com>
References: <Pine.LNX.4.63.0601190027320.8060@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601190027320.8060@alpha.polcom.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:14:56AM +0100, Grzegorz Kulewski wrote:
> Hi,
> 
> I managed to get something like this:
> 
> kernel BUG at mm/shmem.c:836!
> Jan 17 23:31:42 kangur [4312977.009000] CPU:    0
> Jan 17 23:31:42 kangur [4312977.009000] EIP:    0060:[<b014a429>] 
> Tainted: P      VLI

Can you duplicate this on a 2.6.15 or newer kernel, without a closed
source driver loaded?

thanks,

greg k-h
