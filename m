Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbSKAFfR>; Fri, 1 Nov 2002 00:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKAFfR>; Fri, 1 Nov 2002 00:35:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27140 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265626AbSKAFfR>;
	Fri, 1 Nov 2002 00:35:17 -0500
Date: Thu, 31 Oct 2002 21:38:42 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bare pci configuration access functions ?
Message-ID: <20021101053841.GE13031@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF6E@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF6E@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 08:52:24PM -0800, Lee, Jung-Ik wrote:
> Minor fix to the code.
> A patch to a flying patch ;-)

Ok, maybe just because I've eaten too much candy tonight, but I do not
understand where you are trying to go with this odd pseudo code.

What's wrong with the _existing_ pci_config_read() and
pci_config_write() function pointers that ia64 and i386 have?  Can't you
just look into if the other archs can set them to the proper function in
their pci init functions too?

thanks,

greg k-h
