Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTCCO1r>; Mon, 3 Mar 2003 09:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTCCO1r>; Mon, 3 Mar 2003 09:27:47 -0500
Received: from poup.poupinou.org ([195.101.94.96]:65041 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265414AbTCCO1q>; Mon, 3 Mar 2003 09:27:46 -0500
Date: Mon, 3 Mar 2003 15:37:43 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roger Luethi <rl@hellgate.ch>, bert hubert <ahu@ds9a.nl>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303143743.GN3918@poup.poupinou.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046700547.5890.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046700547.5890.24.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 02:09:07PM +0000, Alan Cox wrote:
> On Mon, 2003-03-03 at 00:39, Roger Luethi wrote:
> > The only thing that came up at the time was a suggestion to replace BUG_ON
> > with while (which I didn't try because I'd like to keep my data).
> 
> That isnt far off what you want. IDE has proper command queuing functionality and
> providing you are suspending in a sleeping context you can do what you are trying
> to do through the IDE layer politely. Take a look at how the various ide taskfile
> ioctls issue commands.
> 

the problem is that the suspend/resume code bypass the this kind of
stuff imho.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
