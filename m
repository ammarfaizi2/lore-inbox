Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDNUPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDNUPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:15:23 -0400
Received: from [12.177.129.25] ([12.177.129.25]:54211 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261582AbUDNUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:15:21 -0400
Message-Id: <200404142054.i3EKsGvx008321@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Kurt Garloff <garloff@suse.de>, Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches 
In-Reply-To: Your message of "Wed, 14 Apr 2004 20:30:21 +0200."
             <20040414183021.GQ16701@tpkurt.garloff.de> 
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414094702.GC8888@mail.shareable.org>  <20040414183021.GQ16701@tpkurt.garloff.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Apr 2004 16:54:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

garloff@suse.de said:
> I thought UML only runs on i386. And on i386, you have no NX feature.
> You can run i386 UML on AMD64 (with 64bit kernel) though. 

It also runs natively on and64 (i.e. a 64 bit UML).  The UML page table stuff
is going to need to be fixed for NX, but there's no reason that it won't work.

				Jeff

