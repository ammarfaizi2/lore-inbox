Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTKIMIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 07:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKIMIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 07:08:46 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:54150 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262407AbTKIMIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 07:08:45 -0500
Message-ID: <3FAE2EC1.6080307@stesmi.com>
Date: Sun, 09 Nov 2003 13:10:41 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
References: <20031109011205.GA21914%konsti@ludenkalle.de> <20031109023625.GA15392@win.tue.nl> <20031109034940.GA8532@zappa.doom> <20031109115857.GA15484@win.tue.nl>
In-Reply-To: <20031109115857.GA15484@win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries.

> Hmm. msdos.c has
> 
>                         put_partition(state, slot, start, size == 1 ? 1 : 2);
>                         printk(" <");
>                         parse_extended(state, bdev, start, size);
>                         printk(" >");
> 
> The "hda2" is printed by put_partition(). But no " <" is printed.
> An impossible error. Recompile your kernel.

I wouldn't say it's impossible. If the partition isn't recognized
as extended for some reason that code won't be called, will it?
And it'll only print "hda2" for him then.

// Stefan

