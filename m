Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTDTOCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTDTOCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:02:10 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:961 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263581AbTDTOCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:02:09 -0400
Message-ID: <3EA2AAFC.70708@shemesh.biz>
Date: Sun, 20 Apr 2003 17:13:16 +0300
From: Shachar Shemesh <linux-il@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Shachar Shemesh <lkml@shemesh.biz>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org> <3EA24CF8.5080609@shemesh.biz> <20030420130123.GK2528@phunnypharm.org> <3EA2A285.2070307@shemesh.biz> <20030420134712.GM2528@phunnypharm.org>
In-Reply-To: <20030420134712.GM2528@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>If only i386 was my only development environment. Add sparc64 as my
>primary and hppa, ia64, mips, i386, arm and powerpc as secondaries.
>  
>
I don't see why that matters to you. You only need one cvsup able 
machine to sync the local repository. Once it's local, you can check out 
any tree from it using CVS as usual. There is no difference between 
cvsup and rsync in that respect. I'm not sure where and how the sparc 
tree is held, as I understand it's not in the main tree (but is it in 
the main repository?).

In any case, I'm not even sure that cvsup CAN run without an underling 
rsync server. I simply don't know. I do know that cvsup uses rsync for 
files it cannot optimize using its own algorithm.

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


