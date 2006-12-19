Return-Path: <linux-kernel-owner+w=401wt.eu-S932830AbWLSQqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWLSQqh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWLSQqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:46:37 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:34604 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830AbWLSQqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:46:36 -0500
Date: Tue, 19 Dec 2006 11:46:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for
 2.6.19]
In-reply-to: <20061219145627.fabf3d98.diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Diego Calleja <diegocg@gmail.com>,
       Marek Wawrzyczny <marekw1977@yahoo.com.au>
Message-id: <200612191146.30383.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
 <200612192357.45443.marekw1977@yahoo.com.au>
 <20061219145627.fabf3d98.diegocg@gmail.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 08:56, Diego Calleja wrote:
>El Tue, 19 Dec 2006 23:57:45 +1100, Marek Wawrzyczny 
<marekw1977@yahoo.com.au> escribió:
>> I had another, probably crazy idea. Would it be possible to utilize
>> the current vendor/device PCI ID database to create Linux friendliness
>> matrix site?
>
>I've a script (attached) that looks into /lib/modules/`uname
> -r`/modules.pcimap, looks up the IDs in the pci id database and print
> the real name. At least it shows it's possible to know what devices are
> supported ...

FWIW:
[root@coyote src]# python list-kernel-hardware.py
Traceback (most recent call last):
  File "list-kernel-hardware.py", line 70, in ?
    ret = pciids_to_names(data)
  File "list-kernel-hardware.py", line 11, in pciids_to_names
    pciids = open('/usr/share/misc/pci.ids', 'r')
IOError: [Errno 2] No such file or directory: '/usr/share/misc/pci.ids'

That file apparently doesn't exist on an FC6 i686 system

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
