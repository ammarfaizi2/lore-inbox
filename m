Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265419AbTL2AUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTL2AUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 19:20:24 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:10212 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265419AbTL2AUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 19:20:23 -0500
Message-ID: <3FEF7359.9050900@rackable.com>
Date: Sun, 28 Dec 2003 16:20:41 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com> <20031226202700.GD12871@triplehelix.org>
In-Reply-To: <20031226202700.GD12871@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2003 00:20:22.0036 (UTC) FILETIME=[8C18A540:01C3CDA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

   It does seem to imply that the cdrom is still mounted, or that 
something thinks it's still mounted.
