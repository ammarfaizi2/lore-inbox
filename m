Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVBNWnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVBNWnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVBNWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:43:52 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:8222 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261364AbVBNWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:43:36 -0500
Date: Mon, 14 Feb 2005 14:43:19 -0800
From: Greg KH <gregkh@suse.de>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: andersen@codepoet.org, Christian Borntr?ger <christian@borntraeger.net>,
       Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050214224319.GD13110@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211230657.B1635@banaan.localdomain> <20050211221323.GC23606@suse.de> <200502120148.50073.ioe-lkml@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502120148.50073.ioe-lkml@axxeo.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 01:48:49AM +0100, Ingo Oeser wrote:
> Hi,
> 
> Greg KH write:
> > Very nice stuff.  Ok, that's a good reason not to get rid of these
> > files, although they can be generated on the fly from the modules
> > themselves (like depmod does it.)
> 
> Time to resurrect modinfo? ;-)
> Didn't we plan to get rid of that, too?

Not that I know of, modinfo works great for me here :)

> If we like to use information from modules, there should be a scriptable 
> tool to extract this kind of information, otherwise it will be a bitch to 
> maintain those tools.

modinfo works well for me in this manner, it doesn't for you?

thanks,

greg k-h
