Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUAHAce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUAHAce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:32:34 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:56043 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262540AbUAHAcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:32:33 -0500
Date: Wed, 07 Jan 2004 16:32:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <14870000.1073521945@[10.10.2.4]>
In-Reply-To: <20040107195032.GB823@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> NOTE! We do have an alternative: if we were to just make block device 
>> nodes support "readdir" and "lookup", you could just do
>> 
>> 	open("/dev/sda/1" ...)
>> 
>> and it magically works right. I've wanted to do this for a long time, but 
>> every time I suggest allowing it, people scream.
> 
> Hm, that would be nice.  I don't remember seeing it being proposed
> before, what are the main complaints people have with this?

Couldn't the partitions go under "/dev/sdaX/{1,2,3}" and solve the same
problem without doing magic on the devices?

M.

