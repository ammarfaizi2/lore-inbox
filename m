Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbTLZXaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTLZX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:28:51 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:10651 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265260AbTLZX1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:27:01 -0500
Message-ID: <3FECC3C1.5000108@wmich.edu>
Date: Fri, 26 Dec 2003 18:26:57 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com> <20031226202700.GD12871@triplehelix.org>
In-Reply-To: <20031226202700.GD12871@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've had 2.6.0-mm1 not able to allow the button on the cdrom eject the 
cd. the command  eject   however, does work.  No errors are reported 
relating to why the eject button on the cdrom doesn't eject the cd.


Joshua Kwan wrote:
> On Fri, Dec 26, 2003 at 11:54:34AM -0800, Samuel Flory wrote:
> 
>>  What does fuser -kv /mnt/cdrom claim?
> 
> 
> It's /cdrom here. I tried it on both /cdrom and /dev/cdrom after
> unmounting it, and the output was blank.
> 
> While mounted, here was the output:
> 
>                      USER        PID ACCESS COMMAND
> /cdrom               root     kernel mount  /cdrom
> No automatic removal. Please use  umount /cdrom
> 
> I guess that doesn't say much though...
> 


