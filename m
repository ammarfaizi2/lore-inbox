Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbUABVVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUABVVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:21:20 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:61073
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265645AbUABVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:21:19 -0500
Message-ID: <3FF5DCE8.4020008@tmr.com>
Date: Fri, 02 Jan 2004 16:04:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
References: <200312241341.23523.blaisorblade_spam@yahoo.it>
In-Reply-To: <200312241341.23523.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade wrote:
> NEED:
> I have the need to loop mount files containing not plain filesystems, but 
> whole disk images.
> 
> This is especially needed when using User-mode-linux, since to run any distro 
> installer you must partition the virtual disks(and on the host, the backing 
> file of the disk contains a partition table).
> 
> Currently this could be done by specifying a positive offset, but letting the 
> kernel partition code handle this is better, isn't it? Would you ever accept 
> this feature into stock kernel?

UML is on my list of things to learn (as opposed to "try casually and 
ignore") but have you considered using NBD?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
