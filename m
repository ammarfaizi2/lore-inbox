Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbTDJRUm (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTDJRUl (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:20:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:39613 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264114AbTDJRUk (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:20:40 -0400
Date: Thu, 10 Apr 2003 10:32:04 -0700
From: Greg KH <greg@kroah.com>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] unusual_devs entries for Vivicam and others
Message-ID: <20030410173204.GA1629@kroah.com>
References: <20030410155022.0bd6ccd0.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030410155022.0bd6ccd0.hanno@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 03:50:22PM +0200, Hanno Böck wrote:
> While searching for hints how to get the Vivicam 355 working in Linux, I
> found that Lycoris Desktop/LX supports it.
> 
> I looked into their sources and they have a patch for adding
> unusual_devs-Entries to the kernel-source.
> 
> I also found that they have two patches for sony-cameras not in the
> kernel.
> 
> I testet the Vivicam-Patch and it works. I didn't test the
> Sony-patches, so I don't know about them. (I assume they work, ask
> lycoris for details)
> 
> Please apply the Vivicam-Patch to the kernel. I've put the patches
> online, because to get them from lycoris, you have to download their
> source-iso-cd.

Please send these to the usb-storage mantainer.

Also the ranges for some of these devices seems wrong, as if the author
didn't understand that 0x9999 is not the largest value for that field :)

thanks,

greg k-h
