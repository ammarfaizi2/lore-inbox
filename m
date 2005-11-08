Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVKHXb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVKHXb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVKHXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:31:57 -0500
Received: from baikonur.stro.at ([213.239.196.228]:41858 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1030401AbVKHXb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:31:56 -0500
Date: Wed, 9 Nov 2005 00:09:51 +0100
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "Marco D'itri" <md@linux.it>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051108230951.GL11946@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108215641.GA19289@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh, you don't use 'udevstart'?  Oh well...

debian uses a highly patched udevstart and calls it udevsyntesize.
needed some time to figure that out when chasing failures of ubuntu's
initramfs-tools which in debian use the newer udevsyntesize.

the patches can be seen at:
http://ftp.debian.org/debian/pool/main/u/udev/udev_0.071-1.diff.gz
but more easily if you apply that to the unpacked
http://ftp.debian.org/debian/pool/main/u/udev/udev_0.071.orig.tar.gz


--
maks

ps sorry if i trimmed cc, just stepping in and trying to reconstruct
from previous postings.
