Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWEVRCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWEVRCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWEVRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:02:37 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:50907 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1750993AbWEVRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:02:36 -0400
In-Reply-To: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
References: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0980901F-F36D-4A7C-9951-CEF0F0F3558F@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: RAID Sync Speeds
Date: Mon, 22 May 2006 18:02:34 +0100
To: Rainer Shiz <rainer.shiz@gmail.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 2006, at 14:05, Rainer Shiz wrote:

> Hi,
>    I have a general question on operating software RAIDs in linux.
>    I am running md RAID in linux 2.6.12 kernel. I observed that the
> sync speeds
> were always much closer to /proc/sys/dev/raid/speed_limit_min value,
> than
> /proc/sys/dev/raid/speed_limit_max value. I agree that disk activity
> (I/O) and
> other system usage will bring down sync speeds. But I want sync speeds
> to be
> higher at whatever cost. So I thought I will just set max value to
> around
> 500000 and leave the min at 5000. But with idle disk activity and
> otherwise
> idle system usage, I still see sync speeds around 5300Kb/s only.
>
> So Is the 2.6 kernel designed to sync at speeds closer to min than  
> max?
>
> Please advise.

I must admit I keep my settings on the default (1000/200000) and get  
whatever my disks can handle, usually 50-70MB/sec. All this is on a  
completely idle system, doing anything disk bound at all will lower  
these numbers significantly. This is on various SATA controllers, all  
with Seagate drives.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

