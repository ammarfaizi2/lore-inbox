Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRB1QgH>; Wed, 28 Feb 2001 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130260AbRB1Qf5>; Wed, 28 Feb 2001 11:35:57 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:59404 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S130253AbRB1Qfs>; Wed, 28 Feb 2001 11:35:48 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Unmounting and ejecting the root fs on shutdown.
Date: Wed, 28 Feb 2001 16:37:13 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <97j9fp$h1o$1@ncc1701.cistron.net>
In-Reply-To: <E44E649C7AA1D311B16D0008C73304460933B1@caspian.prebus.uppsala.se>
X-Trace: ncc1701.cistron.net 983378233 17464 195.64.65.67 (28 Feb 2001 16:37:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E44E649C7AA1D311B16D0008C73304460933B1@caspian.prebus.uppsala.se>,
Per Erik Stendahl  <PerErik@onedial.se> wrote:
>Mounting a ramdisk for / is doable (I think) but kludgy since you have
>to symlink or mount so many subdirectories. Right now I only have /var
>in a ramdisk (and why _WHY_ is /etc/mtab located in /etc and not
>in /var??).

If /var is on a seperate partition, how are you going to access it
if /var hasn't been mounted yet ?

Mike.
-- 
I live the way I type; fast, with a lot of mistakes.

