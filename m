Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbTDKSCf (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDKSCA (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:02:00 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:28401 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261346AbTDKSBg (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:01:36 -0400
Date: Fri, 11 Apr 2003 20:23:13 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: John Bradford <john@grabjohn.com>
Cc: Greg KH <greg@kroah.com>, oliver@neukum.name, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com,
       Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411182313.GG25862@wind.cocodriloo.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 06:46:09PM +0100, John Bradford wrote:
> > > - Performance. What happens if you plug in 4000 disks at once?
> > 
> > You crash your power supply :)
> 
> [Puzzle]
> 
> Say the power supply had five 5.25" drive power connecters, how many 1
> into 3 power cable splitters would you need to connect all 4000 disks?
> 
> :-)
> 
> John.

Also, assuming 1 second spinup, you would need
4000 seconds == 66.66... minutes == 1.11... hours
for a sequential spinup (which _may_ not crash
the power supply)

Antonio.

