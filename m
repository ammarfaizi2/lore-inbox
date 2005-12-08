Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVLHPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVLHPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVLHPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:50:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:53758 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751197AbVLHPuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:50:07 -0500
Message-Id: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
From: dirk@steuwer.de
To: <rdunlap@xenotime.net>
To: <wli@holomorphy.com>
To: <riel@redhat.com>
To: <linux-kernel@vger.kernel.org>
To: <arjan@infradead.org>
To: <diegocg@gmail.com>
Subject: AW: Re: Linux in a binary world... a doomsday scenario
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-Binford: 6100 (more power)
X-Mailer: Webmail
X-Originating-From: 5356033
X-Routing: DE
X-Message-Id: <5356033$1134056986823172.23.4.15326967144@pustefix153.kundenserver.de-946918476>
Date: Thu, 08 Dec 2005 16:49:46 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.153
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>El Thu, 8 Dec 2005 13:23:11 +0000 (UTC),
>Dirk Steuwer <dirk@steuwer.de> escribió:
>
>
>> For a hardwaredatabase i like to see a structure. Kernel developers are 
>> required to enter the support into the database, when submitting the 
>driver.
>> Ongoing status will be logged there as well. Status and devices can only be 
>
>> entered by kernel developers.
>
>[Please don't remove the CC list]
>
>This sounds like the typical nightmare that never is 100% accurate and
>needs lots of mainteinance (developers not updating the wiki, etc) as
>Lee Revell pointed out.
>
>IMO the one way of creating such database is automating it. If you
>could get a list of the device IDs supported by drivers you 
>could (?) use the pciid/usbid/whatever list to build a user-readable
>database of the devices supported by the linux tree. Maybe it won't
>100% perfect but...

Yes, i can see the problem.
How about interconnecting it with the bugtracker?
If there is a bug, and if it is related to some hardware, it is logged in the database as broken for that kernel version. If the bug is fixed, support status is ok again.
All that needs to be done is entering the device once into the database, status is broken by default, and take it from there?
Then it gets some goals (similar to bugs) assigned if it is a complex device. i.e. for a graphic device:
* 2d graphic support
* 3d graphic support
* framebuffer
* vesa

one can close goals similarly to bugs, and if a second tester find something broken, it gets filed as a bug.
As i see it the system has to be simple to use and if used, provide an advantage to kernel developers. This makes sure it will get used and could provide an instant status about linux hardware support.

regards,
Dirk
