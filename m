Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRF1Sg3>; Thu, 28 Jun 2001 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRF1SgR>; Thu, 28 Jun 2001 14:36:17 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:27399 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S261268AbRF1SgM>; Thu, 28 Jun 2001 14:36:12 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Cosmetic JFFS patch.
Date: Thu, 28 Jun 2001 18:36:11 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9hfter$9e7$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain> <Pine.LNX.4.33.0106281057170.15199-100000@penguin.transmeta.com> <20010628131641.5e10ecca.reynolds@redhat.com>
X-Trace: ncc1701.cistron.net 993753371 9671 195.64.65.67 (28 Jun 2001 18:36:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010628131641.5e10ecca.reynolds@redhat.com>,
Tommy Reynolds  <reynolds@redhat.com> wrote:
>Linus Torvalds <torvalds@transmeta.com> was pleased to say:
>
>> If they are shut off, then where's the drumming? Because if people start
>> making copyright printk's normal, I will make "quiet" the default.
>
>Amen.  This is like editing a program to remove the "harmless" compiler warning
>messages.  If I don't get a useless message, I don't have to decide to ignore
>it.  Describing what's happening is OK; don't gush.

Yep - a driver should print out that it loaded and what hardware it
found. Nothing else.

You know what I hate? Debugging stuff like BIOS-e820, zone messages,
dentry|buffer|page-cache hash table entries, CPU: Before vendor init,
CPU: After vendor init, etc etc, PCI: Probing PCI hardware, 
ip_conntrack (256 buckets, 2048 max), the complete APIC tables, etc

That's stuff that noone cares about. If the system fails to boot
boot it with a debug flag. If it does boot, _fine_.

Mike.


