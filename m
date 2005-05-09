Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVEIX13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVEIX13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEIXX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:23:59 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:26753 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261392AbVEIXWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:22:05 -0400
Date: Mon, 9 May 2005 16:22:07 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050509232207.GB24238@suse.de>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 12:52:02AM +0200, Per Liden wrote:
> On Fri, 6 May 2005, Greg KH wrote:
> 
> [...]
> > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > USB hotplug program can be written with a simple one line shell script:
> > 	modprobe $MODALIAS
> 
> Nice, but why not just convert all this to a call to 
> request_module($MODALIAS)? Seems to me like the natural thing to do.

Because that's not the only thing that the hotplug event causes to
happen.  It's easier to have userspace decide what to do with this
instead.

> [...]
> > Oh, and the upstream module-init-tools maintainer needs to accept that
> > patch one of these days...
> 
> Where can this patch be found?

Just sent it to this same thread.

thanks,

greg k-h
