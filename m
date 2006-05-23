Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWEWHdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWEWHdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWEWHdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:33:32 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:52442 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932094AbWEWHdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:33:31 -0400
Date: Tue, 23 May 2006 00:32:13 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Brice Goglin <brice@myri.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
In-Reply-To: <fa.hVNDQ4A/sPeiQKqlsb6JDQFEpLE@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0605230029560.9585@osa.unixfolk.com>
References: <fa.qrx8XYAhsFvMnCfipnnEkuNPFSA@ifi.uio.no>
 <fa.hVNDQ4A/sPeiQKqlsb6JDQFEpLE@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006, Greg KH wrote:
| Ok, does everyone agree that this patch fixes the issues for them?  I've
| had a few other private emails saying that the current code doesn't work
| properly and hadn't been able to determine what was happening.  Thanks
| for these patches.

I can't speak for the people actually hitting the 8131 problem, but
Brice's latest patch does (as would be expected) work for the
InfiniPath card in systems with 8131 and PCIe (our MSI interrupts
work).

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
