Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJAN5q>; Tue, 1 Oct 2002 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbSJAN5q>; Tue, 1 Oct 2002 09:57:46 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:15786 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261624AbSJAN5p>; Tue, 1 Oct 2002 09:57:45 -0400
Date: Mon, 30 Sep 2002 20:04:33 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB Mass Storage Hangs
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D9910C1.2070301@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.44.0209301239330.8153-100000@behemoth.ts.ray.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually I did see those posts, it's just that I've had the exact same 
> problem on uhci and ohci, and because rmmod usb-storage between
> unplug and plugin avoided the problem, I figured it was solely usb-storage 
> related.

Ah, that wasn't clear to me from your post.  There are some issues
to be dealt with still ... usb-storage error handling has to do the
scsi_eh dance, but its choreography is problematic.

- Dave


> Besides it appears that it's more likely to be just MSystems DiskOnKey 
> related, because for example a similar Fujitsu mass storage works without 
> problems.


