Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJHVRS>; Mon, 8 Oct 2001 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277141AbRJHVRJ>; Mon, 8 Oct 2001 17:17:09 -0400
Received: from frank.gwc.org.uk ([212.240.16.7]:26127 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S277135AbRJHVQ4>;
	Mon, 8 Oct 2001 17:16:56 -0400
Date: Mon, 8 Oct 2001 22:17:21 +0100 (BST)
From: Alistair Riddell <ali@gwc.org.uk>
To: raid@ddx.a2000.nu
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: write/read cache raid5
In-Reply-To: <Pine.LNX.4.40.0110082309400.28345-100000@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.21.0110082213240.29428-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 raid@ddx.a2000.nu wrote:

> So there is no way i can Speedup write to the raid5 array ?
> (memory will be ecc and the server will be on ups)

Your disks go as fast as they go, that is a physical limitation. 

More RAM means your server can store up data blocks to be written when the
disks are less busy. But the data still has to be written to disk
sometime.

More RAM will certainly help by caching reads though.

6 disks raided together means the bottleneck will likely be your network,
unless your server is on gigabit ethernet and has a ton of clients and/or
gigabit to the desktop.

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
Microsoft - because god hates us


