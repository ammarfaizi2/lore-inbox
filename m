Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbTCYDoQ>; Mon, 24 Mar 2003 22:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbTCYDoP>; Mon, 24 Mar 2003 22:44:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47376 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261415AbTCYDoO>;
	Mon, 24 Mar 2003 22:44:14 -0500
Date: Mon, 24 Mar 2003 19:54:51 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Christoph Hellwig <hch@infradead.org>, Dominik Kubla <dominik@kubla.de>,
       linux-kernel@vger.kernel.org
Subject: Re: i2c-via686a driver
Message-ID: <20030325035451.GG11874@kroah.com>
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org> <200303232136.10089.dominik@kubla.de> <20030323204810.A11421@infradead.org> <3E7E2963.4070302@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7E2963.4070302@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:38:43PM +0100, Jan Dittmer wrote:
> Christoph Hellwig wrote:
> >On Sun, Mar 23, 2003 at 09:36:10PM +0100, Dominik Kubla wrote:
> >
> >>Why? It's a valid C99 feature and since the kernel already uses C99 
> >>initializers it won't compile with compilers that choke on C99 comments 
> >>anyway.
> >
> >
> >Because there's a strong preference for traditional C style in the kernel.
> >typedefs are also a valid C feature and we try to avoid them.
> >
> Anyway, here is a corrected version.

Oops, one other thing.  The pci_device_id structure should be
initialized by using the .field = method, not the way the driver is
currently.

Oh, and one patch that adds the Kconfig, Makefile, and driver to the
tree would be great.

thanks again,

greg k-h
