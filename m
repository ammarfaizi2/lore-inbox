Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTAXAiP>; Thu, 23 Jan 2003 19:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbTAXAiP>; Thu, 23 Jan 2003 19:38:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5137 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267456AbTAXAiO>;
	Thu, 23 Jan 2003 19:38:14 -0500
Date: Thu, 23 Jan 2003 16:45:29 -0800
From: Greg KH <greg@kroah.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
Message-ID: <20030124004529.GA11646@kroah.com>
References: <20030123045447.GB6584@kroah.com> <Pine.LNX.4.44.0301231814110.28943-100000@manticore.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301231814110.28943-100000@manticore.sh.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 06:34:42PM +0800, Stanley Wang wrote:
> > > +static struct subsystem hotplug_slot_subsys;
> > 
> > You need to initialize this structure to something, and give it a name.
> > Otherwise all of the slots show up in the top of sysfs, right?  I would
> > really like to see these directories show up in /sys/bus/pci/slots/ if
> > you can get them to go there.
> >
> Done. I move it from "/sys/hotplug_slot" to "/sys/bus/pci/hotplug_slots".
> Is it OK ? 

Thanks, yes, that looks good, along with your other changes.
But can you send me a patch against a clean kernel, and not against your
last patch?  Makes it easier for me to apply that way.

thanks,

greg k-h
