Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTKFPH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTKFPH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:07:26 -0500
Received: from ns.schottelius.org ([213.146.113.242]:38831 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S263680AbTKFPHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:07:24 -0500
Date: Thu, 6 Nov 2003 16:07:33 +0100
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: gadio@netvision.net.il, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi question: 2x
Message-ID: <20031106150733.GI25124@schottelius.org>
References: <20031106115813.GF25124@schottelius.org> <200311061558.40845.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311061558.40845.bzolnier@elka.pw.edu.pl>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz [Thu, Nov 06, 2003 at 03:58:40PM +0100]:
> > 1. why is printk used without KERN_* makro?
> >    like '        printk("[ ");' (267), ide-scsi from 2.6.0test9, version
> > 0.92 (there are more examples)
> 
> Because it was not updated to use KERN_*?

If somebody tells me what KERN_* are possible, I will update
ide-scsi.

> > 2. is the command line hdx=ide-scsi still necessary?
> 
> Yes, IMO "hdx=driver_name" should be removed instead.

I rechecked this: It is not necessary anymore.

> 
> >    -> if yes, we should update the help
> 
> Dunno.

If I update the helpfile, who takes the patch?

> BTW I don't think you'll get response from gadio.

Why not?

Nico
