Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVEYUHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEYUHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEYUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:07:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:44958 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261546AbVEYUHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:07:44 -0400
Date: Wed, 25 May 2005 13:14:01 -0700
From: Greg KH <greg@kroah.com>
To: Alexey Koptsevich <kopts@atmosp.physics.utoronto.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: delay at starting udev
Message-ID: <20050525201401.GA24887@kroah.com>
References: <Pine.SGI.4.60.0505171406020.13898958@whirlwind.atmosp.physics.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.60.0505171406020.13898958@whirlwind.atmosp.physics.utoronto.ca>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 12:45:23PM -0400, Alexey Koptsevich wrote:
> 
> Hi,
> 
> I experience a major delay (about 5 min on dual CPU 3GHz machine, RedHat 
> AS v4) at system boot-up at the point of "Starting udev:". The references 
> to it I was able to find say that it was fixed in udev releases years ago. 
> Is anything known about this problem?
> 
> >uname -a
> Linux <...> 2.6.11.7 #2 SMP Tue Apr 19 16:46:25 EDT 2005 i686 i686 i386 
> GNU/Linux
> 
> >rpm -q udev
> udev-039-10.8.EL4

That version is _very_ old, so odds are it has been fixed since then :)

I suggest you ask Red Hat about this if you are having problems with
RHEL 4, as they are the ones that support it.

Good luck,

greg k-h
