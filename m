Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWG1NoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWG1NoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWG1NoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:44:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:22155 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161096AbWG1NoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:44:10 -0400
Date: Fri, 28 Jul 2006 15:44:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728134408.GE29217@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 08:25:35AM -0400, Dmitry Torokhov wrote:
> On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:
> >>
> >> "Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
> >> few weeks ago, about moving accelerator-based hard disk parking from
> >> sysfs polling to the the input infrastructure. One unresolved issue
> >> was how to find which input device happens to be the relevant
> >> accelerometer.
> >
> >The current well known methods are:
> >
> >       1) udev/hotplug. It can create device nodes and symlinks based on 
> >       the
> >               capabilities and IDs of an input device.
> >       1a) HAL. It has all the info from hotplug as well.
> >       2) open them all and do the capability checks / IDs yourself.
> >       3) (obsolete, deprecated) parse /proc/bus/input/devices, which
> >               lists all the input devices
> >
> 
> 4) sysfs - all capabilities, IDs, etc for input devices exported there as 
> well.
 
Oh, of course. I don't know how I could forget sysfs here - I had it in
mind when I started writing the list ...

-- 
Vojtech Pavlik
Director SuSE Labs
