Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWG3UqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWG3UqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWG3UqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:46:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:43916 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751353AbWG3UqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:46:17 -0400
Date: Sun, 30 Jul 2006 13:41:55 -0700
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3 does not like an old udev (071)
Message-ID: <20060730204155.GB21794@kroah.com>
References: <44CCEC96.3020607@yahoo.fr> <9a8748490607301043r5ffc1a87u782a24a2695058be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490607301043r5ffc1a87u782a24a2695058be@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 07:43:28PM +0200, Jesper Juhl wrote:
> On 30/07/06, Guillaume Chazarain <guichaz@yahoo.fr> wrote:
> >Hi,
> >
> >When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86,
> >/dev/usblp0
> >is no more created on boot. If I manually create it, it works fine.
> >
> >Vanilla udev from Dapper: version 079 (Documentation/Changes requires
> >udev 071 ;-) ).
> >
> 
> Hmm, udev 071 works fine here...
> i must admit though that I don't have any USB printers, so what I have
> here is probably not 100% comparable.
> Just wanted to point out that udev 071 and 2.6.18-rc3 is not
> universally broken :-)

Yes, it only shows up if you have any devices that use the USB major
number (like a USB printer.)

Or, if you use the -mm tree, there are lots of patches in there that
require an updated udev.

thanks,

greg k-h
