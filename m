Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVIKDMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVIKDMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVIKDMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:12:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:17815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932402AbVIKDMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:12:14 -0400
Date: Sat, 10 Sep 2005 20:07:26 -0700
From: Greg KH <gregkh@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050911030726.GA20462@suse.de>
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 05:48:05PM -0700, David Lang wrote:
> On Fri, 9 Sep 2005, Greg KH wrote:
> 
> >Date: Fri, 9 Sep 2005 14:45:42 -0700
> >From: Greg KH <gregkh@suse.de>
> >To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
> >Cc: linux-kernel@vger.kernel.org
> >Subject: [GIT PATCH] Remove devfs from 2.6.13
> >
> >Here are the same "delete devfs" patches that I submitted for 2.6.12.
> >It rips out all of devfs from the kernel and ends up saving a lot of
> >space.  Since 2.6.13 came out, I have seen no complaints about the fact
> >that devfs was not able to be enabled anymore, and in fact, a lot of
> >different subsystems have already been deleting devfs support for a
> >while now, with apparently no complaints (due to the lack of users.)
> 
> do you really think that there have been that many people who have shifted 
> to 2.6.13 in less then 2 weeks since release?

Ok, how long should I wait then?

> I know that you take personal offense to this code existing, but Andrew 
> pointed out when you proposed these patches before that we need to be 
> acareful here

I know, that's fine.  But if I don't keep trying, how will it ever
happen?  :)

thanks,

greg k-h
