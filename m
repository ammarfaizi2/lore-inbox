Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTA1WYP>; Tue, 28 Jan 2003 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTA1WYP>; Tue, 28 Jan 2003 17:24:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4364 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261427AbTA1WYO>;
	Tue, 28 Jan 2003 17:24:14 -0500
Date: Tue, 28 Jan 2003 14:30:34 -0800
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re: [RFC] Get rid of all procfs stuff for PCI subsystem.
Message-ID: <20030128223034.GM7382@kroah.com>
References: <20030128215644.GA7382@kroah.com> <Pine.LNX.4.44.0301281718090.10921-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301281718090.10921-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 05:21:37PM -0500, Scott Murray wrote:
> 
> Is there a plan to update pci-utils to work with sysfs?  lspci is a pretty
> valuable debugging tool, it would be a shame to lose the use of it in 2.6.

I'm pretty sure it works without the /proc pci stuff already (well the
big tables in there, I think it still needs the individual pci device
entries.)

And yes, sysfs support would be nice, hint, hint, hint...  :)

thanks,

greg k-h
