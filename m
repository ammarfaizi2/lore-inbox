Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWBJMVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWBJMVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWBJMVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:21:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22505 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751093AbWBJMVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:21:52 -0500
Date: Fri, 10 Feb 2006 13:21:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210122131.GC4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060209085344.GF16052@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060209085344.GF16052@boogie.lpds.sztaki.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 09-02-06 09:53:44, Gabor Gombas wrote:
> On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:
> 
> > The backlight interface only supports exporting and setting the current 
> > brightness. For various bits of hardware, the AC and DC brightnesses are 
> > stored separately. Drivers would need to know which brightness value to 
> > export to userspace. I have an HP backlight driver here which would 
> > benefit from this, and I'm looking at the same issue for a Panasonic 
> > one.
> 
> I don't know the backlight interface but extending it to export all
> available brightness values would seem more logical to me.
> 
> If I'd had a laptop I'd hate if I could only set the DC brightness if I
> plug out the AC power.

Still "set current brightness" operation makes a lot of sense.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
