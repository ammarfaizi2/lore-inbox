Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUCJREw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUCJREw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:04:52 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:43529 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262720AbUCJREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:04:51 -0500
Message-ID: <404F4DEA.5010200@techsource.com>
Date: Wed, 10 Mar 2004 12:18:34 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fbconsole, radeon, default mode?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm setting up a Gentoo system, and I have managed (despite my abject 
ignorance) to get fbconsole to work.  Furthermore, I can get fbset to 
work and set whatever mode I want (I hate how fbset uses picoseconds 
instead of megahertz for dotclock, because you can't easily get the 
console display to exactly line up with the X server, but that's neither 
here nor there).

I made an init script to call fbset on boot to set the consoles to the 
mode I want, but there are problems with that I would like to avoid.

What I was wondering is if there was a way to program alternate default 
values into the console driver, say, as kernel config parameters or even 
boot parameters (I don't care which)...  I could even tweak the source 
code!  I don't want to give it just a resolution and have it GUESS about 
timing numbers, because I had to specially tweak the numbers to get 
console and X to line up, so I want to give the driver complete default 
timings.

I have searched the kernel docs, and I have googled to no avail.  Can 
someone here give me some suggestions?


I'm running the latest Gentoo 2.4 kernel which is called 
"2.4.22-gentoo-r7", and I have a Radeon 9000 Pro card.

Thanks!

