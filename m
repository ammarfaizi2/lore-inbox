Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279722AbRJYIJT>; Thu, 25 Oct 2001 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279723AbRJYIJF>; Thu, 25 Oct 2001 04:09:05 -0400
Received: from marine.sonic.net ([208.201.224.37]:30836 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S279722AbRJYIIu>;
	Thu, 25 Oct 2001 04:08:50 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 25 Oct 2001 01:09:23 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11
Message-ID: <20011025010922.B24125@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24102.1003989096@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 03:51:36PM +1000, Keith Owens wrote:
> Check syslog for any error messages.  The only unusual thing is that
> modprobe is running in safe mode (user supplied input data) which

Ok.  Another point of interest.

If I do ``head /dev/scd0'' as a user, it fails.

If I do ``head /dev/scd0'' as root, it works.

I had always thought that since I could autoload the sound stuff as a
normal user, that this would work as well.

Course, I also just noticed that rmmod -a doesn't unload modules either.
Grrrr.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
