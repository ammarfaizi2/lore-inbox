Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbUKMNqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbUKMNqh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUKMNqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:46:36 -0500
Received: from user-0c99gdv.cable.mindspring.com ([24.148.193.191]:2435 "EHLO
	tuxq.com") by vger.kernel.org with ESMTP id S262759AbUKMNol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:44:41 -0500
Message-ID: <41960FC8.3040004@tuxq.com>
Date: Sat, 13 Nov 2004 08:44:40 -0500
From: "Steven E. Woolard" <tuxq@tuxq.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem: 2.4.26/27 & 2.6.9 Audio CD Burning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reproduced this problem on my system with 2.4.26, 2.4.27, and 
2.6.9. When trying to burn an audio CD with cdrecord, the system load 
average will skyrocket (relitively speaking) up to 4 or 5 sometimes 
reaching 10 or higher. This does not happen with data CD's or at all 
with 2.6.7 kernel. I used scsi emulation (of course) on 2.4.26 and 
2.4.27--not 2.6.9.

Side Notes:
	DMA is enabled, I have tried downgrading cdrtools, and if I 			remember 
correctly it has the same problem in 2.6.8(.1).

Hardware:
	AMD Athlon XP 2400+
	1024MB RAM
	VIA VT82C686 Southbridge (IDE Controller)
	LITE-ON LTR48246S CDRW Drive
