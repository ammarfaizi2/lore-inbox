Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272271AbTGYTa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272272AbTGYTag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:30:36 -0400
Received: from dialpool-210-214-91-218.maa.sify.net ([210.214.91.218]:43166
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272271AbTGYTa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:30:28 -0400
Date: Sat, 26 Jul 2003 01:14:50 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Has this been fixed yet?
Message-ID: <20030725194450.GA4724@localhost.localdomain>
References: <20030725175141.GA3290@localhost.localdomain> <20030725181407.GB2620@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725181407.GB2620@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 02:14:07PM -0400, Greg KH wrote:
> On Fri, Jul 25, 2003 at 11:21:41PM +0530, Balram Adlakha wrote:
> > I posted before but nobody seems to have read it.
> > I get his _every_time_ I unload emu10k1 (OSS) module on 2.6.0-test1:
> > 
> > Call Trace:
> > [<c018e261>] devfs_remove+0x9e/0xa0
> 
> Nope:
> 	http://bugme.osdl.org/show_bug.cgi?id=963
> 
> Feel free to add your comments to this bug to let people know about it.
> 
> thanks,
> 
> greg k-h

btw, which part of the kernel is responsible for finding out if devfs is in use or not _even_ when devfs is not compiled in? There seems to be a problem here, why is there any code running in my kernel to find out if devfs "exists" or not even when its not compiled in? Its not available as module is it?
According to that osdl bug report page it seems this thing is almost unnoticed.
I really don't like to see error messages even if they are harmless...(a tiny bit of my cpu power was used to remove a virtual device that doesn't exist, and also to display the error message on the screen, and not to mention that it actually increases the kernel image size by a few bytes using a few extra bytes of my precious ram)
