Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWAPHfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWAPHfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWAPHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:35:44 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:19172 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932228AbWAPHfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:35:44 -0500
X-Sasl-enc: oWBreXQaS8lmohUusT7f0w5bPxTuGcwrnCFLE0meJhsT 1137396943
Message-ID: <43CB4CC3.4030904@fastmail.co.uk>
Date: Mon, 16 Jan 2006 15:35:31 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060114)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: io performance...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been referred to this list from the linux-raid list.

I've been playing with a RAID system, trying to obtain best bandwidth
from it.

I've noticed that I consistently get better (read) numbers from kernel 2.6.8
than from later kernels.

For example, I get 135MB/s on 2.6.8, but I typically get ~90MB/s on later
kernels.

I'm using this :

<http://www.sharcnet.ca/~hahn/iorate.c>

to measure the iorate. I'm using the debian distribution. The h/w is a MegaRAID
320-2. The array I'm measuring is a RAID0 of 4 Fujitsu Max3073NC 15Krpm drives.

The later kernels I've been using are :

2.6.12-1-686-smp
2.6.14-2-686-smp
2.6.15-1-686-smp

The kernel which gives us the best results is :

2.6.8-2-386

(note that it's not an smp kernel)

I'm testing on an otherwise idle system.

Any ideas to why this might be? Any other advice/help?

Thanks!

Max.
