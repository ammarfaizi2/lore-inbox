Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281153AbRKOXFL>; Thu, 15 Nov 2001 18:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281156AbRKOXFB>; Thu, 15 Nov 2001 18:05:01 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:28935 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281153AbRKOXE4>;
	Thu, 15 Nov 2001 18:04:56 -0500
Date: Thu, 15 Nov 2001 16:03:30 -0800
From: Greg KH <greg@kroah.com>
To: Martin McWhorter <m_mcwhorter@prairiegroup.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011115160330.C12675@kroah.com>
In-Reply-To: <200111151807.fAFI7XN30496@devserv.devel.redhat.com> <3BF40D17.4060501@prairiegroup.com> <20011115141430.B10133@devserv.devel.redhat.com> <3BF41E17.5080200@prairiegroup.com> <20011115152432.A26630@devserv.devel.redhat.com> <3BF433EE.40403@prairiegroup.com> <20011115170148.A19715@devserv.devel.redhat.com> <3BF43E55.80401@prairiegroup.com> <20011115171751.A22915@devserv.devel.redhat.com> <3BF44444.7010101@prairiegroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF44444.7010101@prairiegroup.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 22:41:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 04:40:04PM -0600, Martin McWhorter wrote:
> 
> >Try to rename /sbin/hotplug into something else _temporarily_,

Easier to just do:
	echo "/bin/true" > /proc/sys/kernel/hotplug

Then change it back later to /sbin/hotplug when you are done testing, or
just reboot :)

thanks,

greg k-h
