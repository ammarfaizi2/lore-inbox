Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290658AbSBOTQF>; Fri, 15 Feb 2002 14:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290662AbSBOTPz>; Fri, 15 Feb 2002 14:15:55 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:57870 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290658AbSBOTPl>;
	Fri, 15 Feb 2002 14:15:41 -0500
Date: Fri, 15 Feb 2002 11:11:23 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020215191123.GA3082@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0202150956400.829-100000@segfault.osdlab.org> <Pine.LNX.4.33.0202151019590.829-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202151019590.829-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 18 Jan 2002 17:10:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 10:22:05AM -0800, Patrick Mochel wrote:
> 
> On Fri, 15 Feb 2002, Patrick Mochel wrote:
> 
> > 
> > > no, it doesn't solve the problem. i would like to test it whith 
> > > preemtible kernel not set but it doesn't boot.
> > 
> > While Greg's patch did fix part of the problem, the rest of it was on my 
> > end. Could you try this patch, and see if helps?
> 
> Actually, the patch that I sent is against my current tree, which includes 
> some changes that I've already pushed to Linus. If you're using BK, you 
> should be able to pull his current tree (if you're into that kinda thing). 
> Or, wait until -pre2. Sorry about that.

Your current tree, + this patch, + my patch solves all of the unloading,
removing, and loading problems that I had been seeing.

Thanks for finding this.

greg k-h
