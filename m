Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTDKXO3 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTDKXO3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:14:29 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:54750 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S262000AbTDKXOY (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:14:24 -0400
Date: Fri, 11 Apr 2003 16:25:07 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411232507.GC4917@ca-server1.us.oracle.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com> <20030411195843.GO1821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411195843.GO1821@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:58:43PM -0700, Greg KH wrote:
> > There's going to be a war over this naming, and that's why this is
> > hard.
> 
> No, there isn't.  That's what I am trying to completely avoid with udev.
> It will allow you to plug in whatever device naming scheme that you
> want.

	And this is exactly what we can't have happen.  If I am an
administrator, I don't want to have to write all my scripts to do:

if [ -f /etc/redhat-release ]
then
    DISKPREFIX="/dev/disk"
elif [ -f /etc/unitedlinux-release ]
then
    DISKPREFIX="/dev/disc"
elif [ -f /dev/volume0 ]
then
    DISKPREFIX="/dev/volume"
elif 
    ...


	Please, let's not repeat GNOME/KDE, OpenLook/Motif,
mkinitrd/mkinitrd, etc for all our devices.

Joel

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
