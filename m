Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030640AbWJDIMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbWJDIMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWJDIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:12:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:65432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030640AbWJDIMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:12:14 -0400
Date: Wed, 4 Oct 2006 01:12:13 -0700
From: Greg KH <gregkh@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>, Michael Buesch <mb@bu3sch.de>
Subject: Re: debugfs oddity
Message-ID: <20061004081213.GA3477@suse.de>
References: <1159781104.2655.47.camel@ux156> <20061003052839.GA18989@suse.de> <1159946446.2817.2.camel@ux156>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159946446.2817.2.camel@ux156>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:20:46AM +0200, Johannes Berg wrote:
> On Mon, 2006-10-02 at 22:28 -0700, Greg KH wrote:
> 
> > sysfs works much differently here, as does configfs.  debugfs just uses
> > the vfs layer's ramfs stack, so any potential problem here is probably
> > also present in ramfs.  Have you tried that out?
> 
> Just had a go -- ramfs works as expected, at least when I do the dance
> from userspace as I had in (a')-(d').

I don't understand.  Does ramfs have the same issues you feel debugfs
has?  Or does it work like a disk based file system?

thanks,

greg k-h
