Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWBJVfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWBJVfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWBJVfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:35:04 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:37266 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932204AbWBJVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:35:02 -0500
Date: Fri, 10 Feb 2006 16:35:01 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Message-ID: <20060210213501.GA29940@csclub.uwaterloo.ca>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org> <43ED04E9.9040900@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ED04E9.9040900@cfl.rr.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 04:26:01PM -0500, Phillip Susi wrote:
> If that is what is going on, there is nothing linux can do about it; 
> it's a limitation of the hardware.  The IDE controller can only accept 
> one command at a time, so if that command takes a while to complete, the 
> other drive on the same channel can not be accessed until the first 
> command completes. 
> 
> If the system doesn't come back though after sufficient time has gone by 
> for the burn to complete, then this is probably not what is happening.  
> I'd suggest using magic-sysreq to force an unmount and reboot, then see 
> if there's anything in the logs. 

Perhaps a good test would be to try cdrecord from the command line to
blank the cd, to avoid issues to do with X, xcdroast, etc.  Just the
minimum you can have.

Also what command line does xcdroast generate for the blanking?

Len Sorensen
