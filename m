Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSKLPiy>; Tue, 12 Nov 2002 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKLPiy>; Tue, 12 Nov 2002 10:38:54 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48399 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261624AbSKLPix>;
	Tue, 12 Nov 2002 10:38:53 -0500
Date: Tue, 12 Nov 2002 07:40:33 -0800
From: Greg KH <greg@kroah.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs
Message-ID: <20021112154032.GA30343@kroah.com>
References: <20021112093259.3d770f6e.spyro@f2s.com> <1037094221.16831.21.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037094221.16831.21.camel@bip>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 10:43:41AM +0100, Xavier Bestel wrote:
> 
> I'm wondering if a totally userspace solution could replace devs ?
> Something using hotplug + sysfs and creating directories/nodes as they
> appear on the system. This way, the policy (how do I name what) could be
> moved out of the kernel.

Yes, that is _exactly_ what I am working on doing, and have stated as
such on this list a number of times in the past.

As for it being after the feature freeze comment, like Alan noted,
everything is already present to do this, it's just going to take some
more notifiers being added and some userspace code written.

And no, even if all of this gets done, I would not want to remove devfs
from the kernel, yet :)

thanks,

greg k-h
