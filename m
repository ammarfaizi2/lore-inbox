Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311782AbSC2UHn>; Fri, 29 Mar 2002 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311786AbSC2UHe>; Fri, 29 Mar 2002 15:07:34 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:63498 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311782AbSC2UHU>;
	Fri, 29 Mar 2002 15:07:20 -0500
Date: Fri, 29 Mar 2002 12:06:58 -0800
From: Greg KH <greg@kroah.com>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel notification to user space task
Message-ID: <20020329200658.GE14216@kroah.com>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067CAA@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 01 Mar 2002 16:58:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 10:50:13PM +0530, Amol Kumar Lad wrote:
> 
> for example..if my driver detects that interface 'eth0' is coming up, it
> should send a indication to user task saying 'network interface eth0 is up'

If this is not just a hypothetical example, this kind of userspace
notification is already present in the kernel.  /sbin/hotplug gets
called when ever any network interface is brought up or down.  See the
documentation at linux-hotplug.sf.net for more information if you're
curious.

thanks,

greg k-h
