Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUIVWA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUIVWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUIVWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:00:58 -0400
Received: from mr02.conversent.net ([204.17.65.6]:40114 "EHLO
	mr02.conversent.net") by vger.kernel.org with ESMTP id S266218AbUIVWAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:00:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Is there a user space pci rescan method?
Date: Wed, 22 Sep 2004 18:00:07 -0400
Message-ID: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there a user space pci rescan method?
thread-index: AcSg6AOKOjzlNd/iTQGmwTTpGw3FjgAB1NBg
From: "Dave Aubin" <daubin@actuality-systems.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I know very little about hotplug, but does make sense.
How do you motivate a hotplug insertion event?  Or should
I just go read the /docs on hotplugging?  Any help is
Appreciated:)

Thanks,
Dave:) 

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Wednesday, September 22, 2004 4:05 PM
To: Dave Aubin
Cc: Linux Kernel Mailing List
Subject: Re: Is there a user space pci rescan method?

On Mer, 2004-09-22 at 21:30, Dave Aubin wrote:
> Hi,
>  
>   Is there a user space or perhaps simple kernel module way to rescan 
> the pci bus?  I currently have a user mode program modify the pci bus,

> but I can not push the user mode program to the bios for reasons I 
> can't get in to.

Take a look at drivers/hotplug. As far as Linux is concerned you've got
a hotplug PCI slot if you have to poke at it. Alternatively if its a
general funny such as a card you have to poke to reveal devices behind
it a PCI quirk would probably do the trick.

