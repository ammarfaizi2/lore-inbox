Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbRCOByp>; Wed, 14 Mar 2001 20:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRCOByf>; Wed, 14 Mar 2001 20:54:35 -0500
Received: from monza.monza.org ([209.102.105.34]:25353 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131612AbRCOByX>;
	Wed, 14 Mar 2001 20:54:23 -0500
Date: Wed, 14 Mar 2001 17:53:16 -0800
From: Tim Wright <timw@splhi.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010314175316.A1650@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AAF8A71.1C71D517@faceprint.com> <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu> <20010314082643.A1044@kochanski.internal.splhi.com> <20010314101526.A15137@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314101526.A15137@wirex.com>; from greg@kroah.com on Wed, Mar 14, 2001 at 10:15:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 10:15:26AM -0800, Greg KH wrote:
[My ramblings on device naming database deleted]
> This comes up a lot with regards to USB devices too.  One of the
> usb-serial drivers (the edgeport driver) did something like this by
> looking at the topology of the USB bus and where a specific device was
> (it was also helped by unique serial numbers) and allowed the devices to
> be assigned device nodes based on the topology and a small user space
> program.  I'm going to try to do this for all usb-serial devices in 2.5
> 
> I can see a scheme like this being very useful for all USB, FireWire,
> scsi, etc type of devices.
> 
> And no, I don't think that having some type of device naming "database"
> is overkill and will eventually make it into parts of the kernel (the
> "database" living outside of the kernel of course...)
> 

Well, if it sounds useful, I can look into putting up the design documentation
(yes, shock, horror, there is some :-). It's pretty thorough and covers most
of the issues involved, and hence might be a good talking point, even if we
chose to implement quite differently.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
