Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTD3KTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbTD3KTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:19:50 -0400
Received: from WARSL401PIP4.highway.telekom.at ([195.3.96.79]:44891 "HELO
	email05.aon.at") by vger.kernel.org with SMTP id S261185AbTD3KTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:19:49 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: John Bradford <john@grabjohn.com>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop - Kernel bug?
Date: Wed, 30 Apr 2003 12:31:37 +0200
User-Agent: KMail/1.5
Cc: nuno.silva@vgertech.com (Nuno Silva),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
References: <200304301021.h3UALumk000956@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304301021.h3UALumk000956@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301231.37101.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 12:21, John Bradford wrote:
> > On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> > > Hello!
> > >
> > > Hermann Himmelbauer wrote:
> > > > Well - anyway, the kernel boots but right stops after:
> > > > INIT: Entering runlevel:3
> > > >
> > > > The next line is:
> > > > INIT: open(/dev/console): Input/output error
> > > > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > > > ...
> > > >
> > > > That's it.
> > >
> > > Maybe you striped too much and didn't include *any* console type
> > > (serial, vga or framebuffer)? :)
> >
> > Well - by chance we found another old Laptop, an IBM Thinkpad 350 (the
> > old was model 340) and found a RAM extension, so we have no 36MB RAM.
> >
> > But - guess what: The error still persists!
> >
> > I am quite clueless - maybe it has something to do with the IDE
> > subsystem? We put a 4GB 2.5'' HD in this old Laptop, but the harddisk is
> > correctly recognized by Linux (also Partition check), grub is also
> > working and it Linux also mounts the partition.
> >
> > Is there any way to get more information out of the kernel?
>
> What happens if you with with init set to be a shell?  E.G. init=/bin/bash

Well, I would really like to try this - but it seems that this laptop needs a 
special keyboard driver. It has a german keyboard layout and there is no way 
to get some special characters, especially "/".

Normally with german keyboards, "/" is mapped on the "-" key, but not on this 
one - some keys are simply dead, I can also not get the "[" and "\" etc. In 
"grub" there seems to be no way cut&paste the "/" from "root=/dev/hda3"

I will try to generate a bootdisk and append it with "rdev".

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

