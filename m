Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263213AbTCSXff>; Wed, 19 Mar 2003 18:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263197AbTCSXff>; Wed, 19 Mar 2003 18:35:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49418 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263213AbTCSXdg>;
	Wed, 19 Mar 2003 18:33:36 -0500
Date: Wed, 19 Mar 2003 15:32:19 -0800
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [2.4] Memleak in drivers/usb/hub.c::usb_reset_device
Message-ID: <20030319233218.GA17620@kroah.com>
References: <20030312194133.GA27968@linuxhacker.ru> <20030314193718.GC7560@kroah.com> <20030314200204.GC22018@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314200204.GC22018@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 11:02:04PM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Mar 14, 2003 at 11:37:19AM -0800, Greg KH wrote:
> > >    There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
> > >    on error exit path. See the patch.
> > >    Found with help of smatch + enhanced unfree script.
> > And yes, as David said, there is another kind of error in this area for
> > 2.5.  Patches to clean that up would be appreciated.
> 
> Ok, I guess something like that should work:

I've applied this to my trees, thanks.

greg k-h
