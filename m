Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTDKTRo (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTDKTRo (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:17:44 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:41171 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S261485AbTDKTRn (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:17:43 -0400
Date: Fri, 11 Apr 2003 12:28:27 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411192827.GC31739@ca-server1.us.oracle.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E970A00.2050204@cox.net>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:31:28AM -0700, Kevin P. Fleming wrote:
> - if any partitions are found, they are registered with the kernel using 
> device-mapper ioctls
> - because these new "mapped sections" of the drive are _also_ usable block 
> devices in their own right, they generate hotplug events

	In reality, we need /dev/disk0 for disks, and /dev/part0 for
partitions, and /dev/lv0 for logical volumes from the LVM.  There's
going to be a war over this naming, and that's why this is hard.

Joel

-- 

"And yet I fight,
 And yet I fight this battle all alone.
 No one to cry to;
 No place to call home."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
