Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268741AbRGZXwz>; Thu, 26 Jul 2001 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268739AbRGZXwq>; Thu, 26 Jul 2001 19:52:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:40464 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S268736AbRGZXwb>;
	Thu, 26 Jul 2001 19:52:31 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107262352.f6QNqbf488387@saturn.cs.uml.edu>
Subject: Re: [PATCH] 2.4.7 Add support for Dynamic Disks
To: aia21@cus.cam.ac.uk (Anton Altaparmakov)
Date: Thu, 26 Jul 2001 19:52:36 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E15Pu2w-0005bt-00@libra.cus.cam.ac.uk> from "Anton Altaparmakov" at Jul 26, 2001 11:55:58 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> - Patch adds support for Dynamic Disks which are introduced by Windows
> 2000 and are also used by Windows XP, thus allowing people with dual-boot
> configurations access to their Windows dynamic disk partitions from Linux.
...
> Note that we just do it for all partitions in order. We perform no special
> treatment when partitions are part of raid arrays, etc, we just create
> each member partition as one device (hdb5, etc), handling raid arrays is
> up to future extensions / user space tools / the users to deal with.

Linux has long held an interoperability advantage over UNIX and BSD
due to the use of normal PC disk partitions.

Now a new standard is here. We must swallow our pride and accept it,
tossing out our old LVM format. It's time to embrace and extend.
