Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287866AbSBIAR3>; Fri, 8 Feb 2002 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIART>; Fri, 8 Feb 2002 19:17:19 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5902 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287866AbSBIARH>;
	Fri, 8 Feb 2002 19:17:07 -0500
Date: Fri, 8 Feb 2002 16:14:05 -0800
From: Greg KH <greg@kroah.com>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: USB OOPS persists in 2.5.3-dj4
Message-ID: <20020209001405.GG27610@kroah.com>
In-Reply-To: <3C644F9B.4050702@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C644F9B.4050702@fuse.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 11 Jan 2002 21:40:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 05:22:19PM -0500, Nathan wrote:
> Similarly to what I reported for 2.5.3-dj1, the following big bunch of 
> OOPSes occur when the usb-uhci module is unloaded.  Something similar 
> happens with uhci, but I have not tested it.

This looks like the symptom of my driverfs patches for USB that ended up
in the -dj kernels.  I don't know which version of that patch is in the
-dj kernel.

Can you let me know if 2.5.4-pre3 has this problem?

thanks,

greg k-h
