Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264311AbTCUXou>; Fri, 21 Mar 2003 18:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264312AbTCUXou>; Fri, 21 Mar 2003 18:44:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36872 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264311AbTCUXos>;
	Fri, 21 Mar 2003 18:44:48 -0500
Date: Fri, 21 Mar 2003 15:55:53 -0800
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, dsteklof@us.ibm.com
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030321235553.GB18010@kroah.com>
References: <20030321014048.A19537@baldur.yggdrasil.com> <3E7B79D5.3060903@cox.net> <20030321232131.GA18010@kroah.com> <3E7BA329.2060806@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7BA329.2060806@cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:41:29PM -0700, Kevin P. Fleming wrote:
> Greg KH wrote:
> >>Are you still considering smalldevfs for 2.6 inclusion? If not, then I'd 
> >>like to discuss with you (and Greg KH) the possibility of just 
> >>eliminating devfs entirely, and moving to a userspace version that is 
> >>driven entirely by /sbin/hotplug.
> >
> >
> >You mean with something like this:
> >	http://www.linuxsymposium.org/2003/view_abstract.php?talk=94
> >:)
> >
> 
> Yep, that's the one. Sounds very simple and straightforward to me. The most 
> complex part will be defining some file structure to define the user's 
> desired naming policy to the agent that handles the hotplug events.

Exactly.  Luckily it looks like I'm starting to get a lot of help with
this :)

As I'm still working on providing enough support from within sysfs to
export all the data we need, Dan Stekloff (cced) has started to work on
a design document for how the userspace stuff will work.

I just need a few more hours per day...

thanks,

greg k-h
