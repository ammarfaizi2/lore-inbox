Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbUK3RxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUK3RxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbUK3RuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:50:07 -0500
Received: from smtp09.auna.com ([62.81.186.19]:48554 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262220AbUK3Rtr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:49:47 -0500
Date: Tue, 30 Nov 2004 17:49:44 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de>
	<1101834765l.8903l.4l@werewolf.able.es>
	<Pine.LNX.4.53.0411301835511.11795@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411301835511.11795@yvahk01.tjqt.qr> (from
	jengelh@linux01.gwdg.de on Tue Nov 30 18:37:31 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101836984l.13015l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.30, Jan Engelhardt wrote:
> 
> >I use udev, so there is no hd[a-d] nodes on /dev. And cdrecord
> >_EXITS_ as soon as it founds a non-existent device !!!
> 
> You can find something that does not exist?

Err, as it tries to open a device and it does not exist.
I tries sequentially
hda, hdb, hdc.. up to 256 until it finds something to open.
If it exists, but has not permissions, it keeps trying on the next.
But if it is not present, cdrecord gives up.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


