Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbTJBSa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJBSa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:30:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17935 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263453AbTJBSax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:30:53 -0400
Date: Thu, 2 Oct 2003 20:30:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave O <cxreg@pobox.com>
cc: linux-hfsplus-devel@lists.sourceforge.net, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net>
Message-ID: <Pine.LNX.4.44.0310022028220.8124-100000@serv>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
 <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Oct 2003, Dave O wrote:

>  I get this when building your driver (20030930) against 2.6.0-test6:
> 
> *** Warning: "get_gendisk" [fs/hfsplus/hfsplus.ko] undefined!
> *** Warning: "get_gendisk" [fs/hfs/hfs.ko] undefined!
> 
> any idea how to resolve this?

You can simply remove the code block from get_gendisk to put_disk in 
hfsplus/wrapper.c and hfs/mdb.c.

bye, Roman

