Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbULGVNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbULGVNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbULGVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:13:15 -0500
Received: from news.cistron.nl ([62.216.30.38]:23213 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261939AbULGVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:12:31 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Rereading disk geometry without reboot
Date: Tue, 7 Dec 2004 21:12:27 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cp56br$glj$1@news.cistron.nl>
References: <20041206202356.GA5866@thumper2> <20041207172812.GD11423@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1102453947 17075 62.216.29.200 (7 Dec 2004 21:12:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041207172812.GD11423@lnx-holt.americas.sgi.com>,
Robin Holt  <holt@sgi.com> wrote:
>On Mon, Dec 06, 2004 at 02:23:56PM -0600, Andy wrote:
>> I am using linux kernel 2.6.9 on a san.  I have file systems on
>> non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
>> the XFS file system those disks.  What I would like to avoid rebooting or
>> even unmounting the filesystem if possible.
>> 
>> Is there any way to get the kernel to re-read the disk geometry and change
>> the information it holds without rebooting or reloading the module (which is
>> as bad as a reboot in my case)?
>
>Does anybody know if lvm can do this?

Yes, with LVM and XFS you can grow a logical volume and resize XFS
to fit without taking the filesytem offline.

Mike.

