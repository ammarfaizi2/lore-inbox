Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDKXQa (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDKXQ3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:16:29 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:62091 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S262174AbTDKXQO (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:16:14 -0400
Date: Fri, 11 Apr 2003 16:26:59 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411232659.GD4917@ca-server1.us.oracle.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com> <3E9719C9.6090300@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9719C9.6090300@cox.net>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:38:49PM -0700, Kevin P. Fleming wrote:
> No doubt. And then you get into the situation where the devices themselves 
> have names and/or UUIDs, and you want that to be incorporated into the 
> device name. As it stands today, the only way to achieve that is pass that 
> information to device-mapper so it can create devices with those names.

	Oh, I don't want that ever in the name.  I don't want to have to
know much about my disks, except that once the association is there,
it's there until I delete it.

> Personally, I wouldn't be upset if _all_ "physical volumes" (meaning an 
> accessible block devices or portion thereof) appeared under /dev/volume/... 
> Even logical volumes could be done that way, since they have names as well. 
> I don't really see the need to have "whole disks", "partitions" and other 
> types of volumes in separate directories under /dev, but then I may be way 
> off base with the rest of the world wants to do :-)

	There are multiple reasons.  I need to know what's a disk so I
can configure it.  I need to know what's a partition or a logical volume
so I can put filesystems on it.
	It's always fun these days when folks try to use 'whole disks'
and 'partitions' as equivalent things.  They are indeed from a block
device standpoint, but they aren't from an administration standpoint.

Joel

-- 

Life's Little Instruction Book #99

	"Think big thoughts, but relish small pleasures."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
