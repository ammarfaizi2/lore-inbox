Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUCDGh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUCDGh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:37:28 -0500
Received: from dsl-082-082-147-115.arcor-ip.net ([82.82.147.115]:4483 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S261493AbUCDGhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:37:09 -0500
Message-ID: <4046CE91.50701@kubla.de>
Date: Thu, 04 Mar 2004 07:37:05 +0100
From: Dominik Kubla <dominik@kubla.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com>
In-Reply-To: <20040303000957.GA11755@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
> I've released the 021 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz

Nice work, but  I ran into a problem  on my Debian system and  i did use
the udev-019 permissions file for  Debian. What's the story here anyway?

I seem to be unable to assign group "cdrom" to my ATAPI DVD/CD-RW drive.
It appears to me that the permissions syntax is missing a possibility to
overide the owner/group based upon the class of the device.

Is there a way to distinguish between CD-ROM, DVD-ROM and writers? It is
not unusual  these days to  have at least a  DVD-ROM and CD-Writer  in a
desktop system. If you look at the  latest offers from Dell you will see
that they tend to include a DVD-ROM  and a DVD+RW drive in at least some
configurations. So  it would  be nice  if udev would  be able  to create
links like "cdwriter", "dvd" and "dvdwriter" out of the box. (And assign
the appropriate group to the device nodes...)

Regards,
   Dominik
-- 
Confirmed bachelor:
	A man who goes through life without a hitch.

