Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRF2WV1>; Fri, 29 Jun 2001 18:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbRF2WVS>; Fri, 29 Jun 2001 18:21:18 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:42885 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S262694AbRF2WVC>; Fri, 29 Jun 2001 18:21:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Date: Fri, 29 Jun 2001 13:19:52 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain> <20010628131641.5e10ecca.reynolds@redhat.com> <9hfter$9e7$1@ncc1701.cistron.net>
In-Reply-To: <9hfter$9e7$1@ncc1701.cistron.net>
MIME-Version: 1.0
Message-Id: <0106291319520Z.01786@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 14:36, Miquel van Smoorenburg wrote:

> You know what I hate? Debugging stuff like BIOS-e820, zone messages,
> dentry|buffer|page-cache hash table entries, CPU: Before vendor init,
> CPU: After vendor init, etc etc, PCI: Probing PCI hardware,
> ip_conntrack (256 buckets, 2048 max), the complete APIC tables, etc

We've got a couple of VA rackmount servers with adaptec scsi controllers that 
print out several SCREENS worth of information as they probe all the busses 
and joyfully announce that yes, there are still hard drives plugged into some 
of them, and even gives me a list of the ones that DON'T have hard drives 
plugged into them.

Interestingly, the bios also goes through a very similar ritual earlier in 
the boot.

Rob
