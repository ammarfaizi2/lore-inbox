Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVHPWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVHPWLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHPWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:11:54 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:22930 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751109AbVHPWLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:11:53 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: udev-067 and 2.6.12?
Date: Tue, 16 Aug 2005 23:12:26 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
References: <200508162302.00900.s0348365@sms.ed.ac.uk> <20050816220544.GA28377@kroah.com>
In-Reply-To: <20050816220544.GA28377@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508162312.26972.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 23:05, Greg KH wrote:
> On Tue, Aug 16, 2005 at 11:02:00PM +0100, Alistair John Strachan wrote:
> > Hi,
> >
> > I just tried upgrading udev 053 to 067 on a 2.6.12 system and although
> > the system booted, firmware_class failed to upload the firmware for my
> > wireless card, prism54 was no longer auto loaded, etc. Even manually
> > loading the driver didn't help.
> >
> > Any reason why 067 wouldn't work with 2.6.12? Do you have to do something
> > special with hotplug prior to upgrading?
>
> What distro are you using?  What rules file are you using?
>
> 067 should work just fine for you, it is for a lot of Gentoo and SuSE
> users right now, on 2.6.12.
>

An LFS from April 05, with the stock 50-udev.rules, 25-lfs.rules (which 
doesn't do anything suspicious, I think; certainly nothing related to my 
problem).

25-lfs.rules does duplicate some of the things in 50-udev.rules, but I think 
that's deliberate (they want to interfere with the stock install as little as 
possible, and the overrides take precedence). I've put my /etc/udev directory 
unmodified up here:

http://devzero.co.uk/~alistair/udev/

If I reinstall 053 and reboot, everything that's broken on 067 works again. Do 
you need a specific hotplug installed?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
