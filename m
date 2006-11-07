Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWKGQNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWKGQNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWKGQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:13:46 -0500
Received: from tag.witbe.net ([81.88.96.48]:35806 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932703AbWKGQNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:13:45 -0500
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>
Cc: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: could not find filesystem /dev/root
Date: Tue, 7 Nov 2006 17:13:25 +0100
Organization: AS2917.net
Message-ID: <00da01c70287$aa8c2420$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.61.0611071514270.11892@yvahk01.tjqt.qr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccCd+kwDb8VEYzpSQeWZonwhUOVQwAD0amQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Yeah, "unless". But the kernel should be considered fuzzy logic in 
> this area :) after all, it does not even need a kernel developer -- a 
> binutils contributor might also change something that results in a 
> change of link order.

Right... but I do change my kernel more often than my binutils ;)
 
>   On the other side, you can run udev _once_ to create device 
> nodes like 
> /dev/disk/by-label/ to allow at least correct booting (possibly using 
> LABEL=) Once the box is up, one can always figure out which drive is 
> which by looking at fdisk or other info. (Gets a little hard when 
> they're all the same manufacturer and type, but then again, LABEL= 
> will work without udev in the "normal" userspace.)

I may give it a try... Using uuid could also be an option but I'm not
sure this can be configured thru fstab...

Paul

