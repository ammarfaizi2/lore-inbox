Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSBIAZk>; Fri, 8 Feb 2002 19:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSBIAZa>; Fri, 8 Feb 2002 19:25:30 -0500
Received: from ns.suse.de ([213.95.15.193]:56081 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287279AbSBIAZV>;
	Fri, 8 Feb 2002 19:25:21 -0500
Date: Sat, 9 Feb 2002 01:25:20 +0100
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Nathan <wfilardo@fuse.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: USB OOPS persists in 2.5.3-dj4
Message-ID: <20020209012519.A9087@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, Nathan <wfilardo@fuse.net>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C644F9B.4050702@fuse.net> <20020209001405.GG27610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020209001405.GG27610@kroah.com>; from greg@kroah.com on Fri, Feb 08, 2002 at 04:14:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 04:14:05PM -0800, Greg KH wrote:
 > On Fri, Feb 08, 2002 at 05:22:19PM -0500, Nathan wrote:
 > > Similarly to what I reported for 2.5.3-dj1, the following big bunch of 
 > > OOPSes occur when the usb-uhci module is unloaded.  Something similar 
 > > happens with uhci, but I have not tested it.
 > This looks like the symptom of my driverfs patches for USB that ended up
 > in the -dj kernels.  I don't know which version of that patch is in the
 > -dj kernel.

 I thought I dropped this in favour of the usb/driverfs changes in 2.5.4pre3,
 it's possible I overlooked something, I'll double check later.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
