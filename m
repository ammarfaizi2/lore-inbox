Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTKAP4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTKAP4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:56:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:40721 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263884AbTKAP4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:56:13 -0500
Date: Sat, 1 Nov 2003 16:56:04 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031101155604.GB530@alpha.home.local>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101082745.GF4640@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

do you have the ability to reboot this beast on a DOS floppy equiped with a
disk editor or even debug ? It would tell you wether it's the IDE
initialization or shutdown which harms the disks. BTW, it may even be your
bios which believes for an unknown reason that it has to write to the
partition table which is not one.

just my 2 cents,
Willy

