Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUETT3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUETT3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265240AbUETT3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:29:21 -0400
Received: from coldfront.acsu.buffalo.edu ([128.205.6.89]:65445 "HELO
	front.acsu.buffalo.edu") by vger.kernel.org with SMTP
	id S265233AbUETT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:29:18 -0400
Subject: Re: Data loss on IDE drive after crash
From: Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <40AD0365.6040003@eng.buffalo.edu>
References: <40AD0365.6040003@eng.buffalo.edu>
Content-Type: text/plain
Organization: State University of New York at Buffalo
Message-Id: <1085081357.2044.1.camel@cassius.public.buffalo.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 May 2004 15:29:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 15:13, Gopikrishnan Sidhardhan wrote:
> Hi,
> 
> I am running Fedora Core 2 on an Athlon 2500+ machine with Samsung 
> Spinpoint SP0411N 40GB hard drive.  When trying to configure the X 
> server for an Nvidia card, the machine froze (this is not the problem).  
> Since I did not have access to any other machines on the network at the 
> time, I hard rebooted it.
> 
> At that point, I had my X configuration file open.  

This is not quite true.  I had just written to it and closed it.  Sorry
for the confusion.



> My root partition is 
> a small ext2 partition, and on reboot the machine fscked this partition 
> and gave me a message like "Deleted i-node for /etc/X11/xOrg.conf 
> CLEARED"  (This is from memory).  On reboot, I found that the X config 
> file mentioned above had been erased.  Not a trace of it remained..:-)
> 
> I don't know if this is a known issue, but I sure would like to hear an 
> explanation.  The kernel is the stock kernel provided along with Fedora 
> Core 2 (2.6.5-1.358).
> 
> Problem is. I can't do more testing for this.  This is a machine I use 
> extensively and I don't want the yank the power on it too much.
> 
> Thanks,
> --Gopi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

