Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbUKQSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUKQSPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUKQSLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:11:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:26598 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262478AbUKQSJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:09:05 -0500
Date: Wed, 17 Nov 2004 09:52:17 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041117175216.GC28285@kroah.com>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 04:42:36PM +0100, Miklos Szeredi wrote:
> > No.  Actually, put it in sysfs, and then udev will create your /dev node
> > for you automatically.  And in sysfs you can put your other stuff
> > (version, etc.) which is the proper place for it.
> 
> Next question: _where_ to put other stuff?  In /proc this has a
> logical place for filesystems: /proc/fs/fsname/other_stuff.  But
> there's no filesystem section in sysfs.
> 
> So?

Feel free to create /sys/fs/ for you to put your stuff in.

thanks,

greg k-h
