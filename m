Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267940AbTAMGgt>; Mon, 13 Jan 2003 01:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbTAMGgt>; Mon, 13 Jan 2003 01:36:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48388 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267940AbTAMGgt>;
	Mon, 13 Jan 2003 01:36:49 -0500
Date: Sun, 12 Jan 2003 22:45:44 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113064544.GA3989@kroah.com>
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3iswuk7xm.fsf_-_@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 10:56:37AM +0100, Andi Kleen wrote:
> 
> - Possibly disable module unloading for ldiscs (seems to be rather broken,
> although Rusty's new unload algorithm may avoid the worst - not completely
> sure)

Max has a patch for this, to add struct module * to a ldisc.  Don't know
if it made it in or not.

> Probably all doable with some concentrated effort.
> 
> Anyone interested in helping ?

I am.

thanks,

greg k-h
