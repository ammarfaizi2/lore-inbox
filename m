Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJAVvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTJAVvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:51:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31760 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262626AbTJAVve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:51:34 -0400
Date: Wed, 1 Oct 2003 23:51:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries
Message-ID: <20031001215120.GA16761@alpha.home.local>
References: <3F733FD3.60502@ericsson.ca> <20031001102631.GC398@elf.ucw.cz> <3F7AD795.1040001@ericsson.ca> <20031001141718.GT7665@parcelfarce.linux.theplanet.co.uk> <3F7B1987.3050104@ericsson.ca> <20031001182440.GV7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001182440.GV7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Wed, Oct 01, 2003 at 07:24:40PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 01, 2003 at 02:14:31PM -0400, Makan Pourzandi wrote:
> > Hi Viro,
> > 
> > Obviously, I failed to show that the main functionality of digsig is to 
> > avoid the execution of __normal__ rootkits, Trojan horses and other 
> > malicious binaries on your system. 
> 
> <shrug> so in a month rootkits get updated and we are back to square 1,
> with additional mess from patch...

I think that's perfectly true, sadly. It may even become the subject of the
phrack article, next to the collection of insmod_without_module_support, etc...

The only useful feature it would provide would be to secure a system against
people who tamper on the media itself, which is fairly trivial on nfsroot. It
may be interesting to ensure that a server farm which all mount their root from
a central server may not be tricked into executing undesired code injected into
the central NFS server.

The same would be true for removable media such as smartmedia, on PDAs or
specialized systems.

Just a few thoughts,
Willy



