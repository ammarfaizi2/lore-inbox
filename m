Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUGPFPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUGPFPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGPFPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:15:51 -0400
Received: from ns0.usq.edu.au ([139.86.2.5]:11015 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id S266477AbUGPETE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 00:19:04 -0400
Message-ID: <40F75738.4040601@usq.edu.au>
Date: Fri, 16 Jul 2004 14:19:04 +1000
From: Ron House <house@usq.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-au, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug or Feature? Multiply mounted device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, apologies for posting here, but I need to ask the guys who know 
for sure. In my fstab, I have two entries for my DOS HD so I can mount 
it with or without CRLF mangling, as follows (sorry for the line splitting):

/dev/hda5   /d      vfat 
rw,suid,dev,async,users,umask=033,uid=1500,gid=1001,conv=b 0 0
/dev/hda5   /dc     vfat 
rw,suid,dev,async,users,umask=033,uid=1500,gid=1001,noauto,conv=a 0 0

I just noticed with my new Linux setup (kernel 2.4.20-8smp - don't know 
what all that means) that it will let me mount both at once, so I can 
see the partition as either /d or /dc at the same time. I may be going 
mad, but I seem to recall with my previous kernel that I couldn't do this.

My question: Bug or feature? If I write all sorts of stuff to both 
logical devices, will it correctly sort it all out on the same physical 
device, or will I wreck the partition? All help much appreciated!

-- 
Ron House     house@usq.edu.au
               http://www.sci.usq.edu.au/staff/house
