Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVIHBLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVIHBLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVIHBLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:11:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:30405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932549AbVIHBLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:11:18 -0400
Date: Wed, 7 Sep 2005 13:31:48 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050907203148.GA6701@kroah.com>
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org> <20050904035341.GO8684@ca-server1.us.oracle.com> <20050904041224.GP8684@ca-server1.us.oracle.com> <20050904044136.GR8684@ca-server1.us.oracle.com> <20050904045444.GS8684@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904045444.GS8684@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:54:45PM -0700, Joel Becker wrote:
> 	Finally, assuming that the sysfs_dirent/configfs_dirent
> arrangement is pretty fleshed out, I think that perhaps this backing
> store could be joined.  Again, no more magic could be added, and it
> would have to handle the sysfs and configfs types in concurrence, but I
> think it could be done.  Again, sysfs folks, please comment.

Thanks for the good explainations.  I still agree with Joel that these
need to be separate fses.

thanks,

greg k-h
