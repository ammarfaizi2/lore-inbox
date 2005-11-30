Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVK3UeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVK3UeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVK3UeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:34:23 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:61342 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750721AbVK3UeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:34:22 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Grant Coady <gcoady@gmail.com>
Subject: Re: [GIT PATCH] USB patches for 2.6.15-rc3
Date: Thu, 01 Dec 2005 07:35:59 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <o52so1136encgsg7amk4f1uprflpa7rj25@4ax.com>
References: <20051130055607.GA4406@kroah.com> <Pine.LNX.4.64.0511301018280.3099@g5.osdl.org> <20051130193559.GA13615@suse.de>
In-Reply-To: <20051130193559.GA13615@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005 11:35:59 -0800, Greg KH <gregkh@suse.de> wrote:

>On Wed, Nov 30, 2005 at 10:23:34AM -0800, Linus Torvalds wrote:
>> 
>> 
>> On Tue, 29 Nov 2005, Greg KH wrote:
>> >
>> >  include/linux/pci_ids.h           |    3 --
>> > 
>> > Grant Coady:
>> >       pci_ids.h: remove duplicate entries
>> 
>> Why is this in the USB tree, and WHY THE HELL DOES IT EXIST IN THE FIRST 
>> PLACE?
>
>Sorry, in the body of the message I stated that I had a pci and a hwmon
>driver patch too.  I should have corrected the Subject: too.
>
>> Not only does it have absolutely nothing to do with USB, it's totally 
>> bogus and incorrect. The commit log is also non-sensical, since it points 
>> to a commit that doesn't even exist in that tree.
>> 
>> It causes
>> 
>> 	drivers/ide/pci/amd74xx.c:77: error: PCI_DEVICE_ID_AMD_CS5536_IDE undeclared here (not in a function)
>> 
>> Grr.
>
>Ugh, I thought Grant wanted this in for the main kernel tree, sorry.
>
>Grant, what git tree were you referring to?

The duplicates appeared in 2.6.15-rc2-mm1, which is what I patched 
against.  Sorry for confusion, thought I was doing the right thing 
finding the commit message in Andrew's 2.6.15-rc2-mm1-broken-out.tar.bz2

Grant.

