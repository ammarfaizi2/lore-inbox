Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265538AbSJXQth>; Thu, 24 Oct 2002 12:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSJXQth>; Thu, 24 Oct 2002 12:49:37 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:273 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265538AbSJXQtg>;
	Thu, 24 Oct 2002 12:49:36 -0400
Date: Thu, 24 Oct 2002 09:54:11 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024165411.GG22654@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF3F@orsmsx102.jf.intel.com> <20021024051008.GA19557@kroah.com> <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp> <20021024061236.GJ19557@kroah.com> <3DB80919.5030500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB80919.5030500@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:52:09AM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >I think we now all agree that resource management should move into a
> >place where it can be shared by all pci hotplug drivers, right?
> >
> >If so, anyone want to propose some common code?
> 
> 
> drivers/pci/setup* is not enough?
> 
> I am surprised that anything needed to be added here...

There was some reason that code would not work out when I looked at it
over a year ago.  But I don't remember why, so I'll go look at it again,
thanks for pointing it out.

greg k-h
