Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUC2Beg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 20:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUC2Beg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 20:34:36 -0500
Received: from sea1-f29.sea1.hotmail.com ([207.68.163.29]:7428 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262561AbUC2Bec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 20:34:32 -0500
X-Originating-IP: [203.103.132.2]
X-Originating-Email: [jbothe@hotmail.com]
From: "John Bothe" <jbothe@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 29 Mar 2004 11:34:31 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea1-F29TqkDlWz37BR00015d97@hotmail.com>
X-OriginalArrivalTime: 29 Mar 2004 01:34:31.0156 (UTC) FILETIME=[FB91BB40:01C4152D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a set of counters in a Kernel module that i want to export to a
userspace application. I originally decided to use a /proc entry and parse
the output whenever the userspace application needed this data, however,
i need more than the 4096 that is allowed in /proc and i'm not too keen
on parsing large chunks of text anyway.

What i would like to do is copy these slabs of text from the kernel to my
userspace application (whenever the application requests it). I've seen the
'copy_to_user' function and it looks usefull, but have no idea where to 
start
or how to use it :-/

Can someone provide and example or point me in the right direction? Or is 
there a better place to ask this question?

Regards
-J

_________________________________________________________________
What's your house worth? Click here to find out:  
http://www.ninemsn.realestate.com.au

