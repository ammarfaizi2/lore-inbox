Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWDHLNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWDHLNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWDHLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:13:05 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:36876 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S964892AbWDHLNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:13:04 -0400
Message-ID: <44379AB8.6050808@superbug.co.uk>
Date: Sat, 08 Apr 2006 12:12:56 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mail/News 1.5 (X11/20060405)
MIME-Version: 1.0
To: linux list <linux-kernel@vger.kernel.org>
Subject: Black box flight recorder for Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have had an idea for a black box flight recorder type feature for 
Linux. Before I try to implement it, I just wish to ask here if anyone 
has already tried it, and whether the idea works or not.

Description for feature:
Stamp the dmesg output on RAM somewhere, so that after a reset (reset 
button pressed, not power off), the RAM can be read and details of 
oopses etc. can be read.

Now, the question I have is, if I write values to RAM, do any of those 
values survive a reset? If any did survive, one could use them to store 
oops output in. I am currently only interested in Intel CPU and AMD CPU 
based motherboards. If only some values survived, one could use some 
sort of redundant encoding so the good values could be recovered.

The main advantage of something like this would be for newer 
motherboards that are around now that don't have a serial port.

If no one has tried this, I will spend some time testing.

James



