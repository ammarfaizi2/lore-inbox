Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSLaQOv>; Tue, 31 Dec 2002 11:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLaQOu>; Tue, 31 Dec 2002 11:14:50 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:18423
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S264646AbSLaQOp>; Tue, 31 Dec 2002 11:14:45 -0500
Message-ID: <3E11C4E2.2050306@WirelessNetworksInc.com>
Date: Tue, 31 Dec 2002 09:25:06 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: Indention - why spaces?]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 16:23:11.0220 (UTC) FILETIME=[E9435340:01C2B0E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> By the way, this sort of thing is a big deal around here, I spend a 
> lot of time getting people to do it all the same way.  It's worth it.
> 

Larry, you can save yourself a lot of trouble, time and money: Create an
indent configuration file and tell your people to use it.  That is
exactly why indent was written many years ago.

Better still, change your commit scripts to automatically run indent
when checking files in.  This works on private projects - it is not
recommended for a public project like GNU/Linux, unless, Linus would
call a halt - indent all files and then carry on, which I'm sure he
won't do, since it is waaaay too much trouble.

With indent, everybody can be happy: You don't like the curly braces
here but rather want them there?  ==> Run indent on your private copy.

BTW, occational windoze users can get the GUIfied 'windent.exe' off my
web site at www.aerospacesoftware.com.  This presents a simple way to
play around with indent; to figure out exactly what schtooopidttt
switches you need to make the code look the way your SQA dork wants...

Also, if you want the whole kernel to be commented and clickable in
html, 'doxygen' does an amazing job with that, even though the kernel
code is not written with doxygen tags.

Since I discovered these two tools, I totally relaxed about code
formatting, since it is simply not an issue anymore.

Cheers,
-- 
Herman


