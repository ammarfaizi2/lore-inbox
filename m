Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbSJXHX7>; Thu, 24 Oct 2002 03:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbSJXHX7>; Thu, 24 Oct 2002 03:23:59 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265334AbSJXHX6>;
	Thu, 24 Oct 2002 03:23:58 -0400
Date: Thu, 24 Oct 2002 00:28:38 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, arne@arne-thomassen.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP cleanups and resource changes - 2.5.44 (1/4)
Message-ID: <20021024072838.GE20180@kroah.com>
References: <20021023151648.GC10638@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023151648.GC10638@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 03:16:49PM +0000, Adam Belay wrote:
> This patch fixes a number of things pointed out by Arne Thomassen.  Also it
> makes a few changes to the resource checking functions in that they now check to
> make sure that resources do not conflict within the same device instead of only 
> other devices.  Although it is rare for this to be a factor it's nice to be able 
> to deal with such situations properly.
> 
> Applies against 2.5.44 with the pnp fix patch.

Thanks, I've taken this on, and the 3 others and added it to the
previous bk tree to be queued to send to Linus when he gets back.

thanks again,

greg k-h
