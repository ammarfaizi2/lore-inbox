Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbTGISUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268529AbTGISUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:20:42 -0400
Received: from granite.he.net ([216.218.226.66]:9737 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S268511AbTGIST5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:19:57 -0400
Date: Wed, 9 Jul 2003 11:18:49 -0700
From: Greg KH <greg@kroah.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPC subsystem
Message-ID: <20030709181849.GA17800@kroah.com>
References: <D9B4591FDBACD411B01E00508BB33C1B01AF03D2@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01AF03D2@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 12:06:14PM +0200, Frederick, Fabian wrote:
> Hi,
> 	I'm trying to port the ipc stuff to work as a subsystem in order to
> have sysfs outputs (/sysfs/ipc/sem {,shm,msg} ) .
> 	Output I have is an early oops (which is not reported in /var/log
> ...)
> 
> 	It seems the ipc stuff init begins before kobject stuff or something
> ?
> 
> "EIP is at sysfs_create_dir

Can you print the whole call trace?

Also, is your kobject initialized to zero before you try to register it?

thanks,

greg k-h
