Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUD1TO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUD1TO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUD1TMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:12:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:39390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265009AbUD1RhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:37:18 -0400
Date: Wed, 28 Apr 2004 10:36:44 -0700
From: Greg KH <greg@kroah.com>
To: Michael_E_Brown@Dell.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
Message-ID: <20040428173643.GF32040@kroah.com>
References: <0960978B185D2848BF5BBAE1BFB343E104E3EC@ausx2kmps315.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0960978B185D2848BF5BBAE1BFB343E104E3EC@ausx2kmps315.aus.amer.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 12:18:21PM -0500, Michael_E_Brown@Dell.com wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com] 
> > 
> > Ok, here are 2 patches.  The first small one is on top of your latest
> > version.  It gets rid of the extra subdirectory, and removes the
> > unneeded kobject from your static structure (NEVER USE A KOBJECT IN A
> > STATIC STRUCTURE!!!!)
> 
> Ok, thanks for the guidance here. I was not aware of this limitation. 

{sigh} I think I need to update the documentation...

> > The secone one is against a clean 2.6.6-rc3 kernel that has 
> > your latest
> > version + my changes.
> > 
> > If you approve of my changes, I'd be glad to add the driver to my bk
> > trees to have it show up in the next -mm release, and I will 
> > push it off
> > to Linus after 2.6.6 is out.  Sound ok?
> 
> This looks good. I'll do a quick compile/boot check. I would really 
> appreciate your help in getting this in. (although I was hoping to get
> it into 2.6.6, I guess it can wait for 2.6.7 :-)

Yes, 2.6.6 is too late, sorry.

Let me know if the patch works for you and then I'll add it to my trees.
It worked for me on my box :)

thanks,

greg k-h
