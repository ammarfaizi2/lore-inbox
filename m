Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbSAGTN7>; Mon, 7 Jan 2002 14:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285266AbSAGTNt>; Mon, 7 Jan 2002 14:13:49 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:49797
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285261AbSAGTNg>; Mon, 7 Jan 2002 14:13:36 -0500
Date: Mon, 7 Jan 2002 13:58:42 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        cate@debian.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107135842.A20420@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, cate@debian.org
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de> <20020107185001.GK7378@kroah.com> <20020107185813.GL7378@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107185813.GL7378@kroah.com>; from greg@kroah.com on Mon, Jan 07, 2002 at 10:58:13AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> On Mon, Jan 07, 2002 at 10:50:01AM -0800, Greg KH wrote:
> > 
> > And the /sbin/hotplug program knows about _all_ devices that the
> > currently compiled kernel can handle due to the MODULE_DEVICE_TABLE tags
> > in the drivers.
> 
> Along these lines, I am very disappointed in looking at the
> autoconfigure stuff in CML2.  It should be taking all of the device and
> driver matching information from the kernel itself, as it is already
> specified there.

I'm taking my rules file from Giacomo Catenazzi, who developed it
originally for a shellscript he wrote.  I don't know how he generates
the hardware probes; for all I know, he's got code groveling through
the module device tables.

I've been meaning to ask you about this, Giacomo.  Where *did* all
those probes come from?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Don't think of it as `gun control', think of it as `victim
disarmament'. If we make enough laws, we can all be criminals.
