Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752375AbWCKIUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbWCKIUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWCKIUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:20:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:59133 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752375AbWCKIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:20:53 -0500
Message-ID: <44128861.20409@free.fr>
Date: Sat, 11 Mar 2006 09:20:49 +0100
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Thunderbird 1.5 (Macintosh/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NFS client hangs under certain circumstances on SMP machine
References: <5LjNF-1Q2-7@gated-at.bofh.it>
In-Reply-To: <5LjNF-1Q2-7@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Croquette wrote:

> However, when I regenerate the file under Windows again (ie. I overwrite
> the old files), and I try to compile the files again under Linux, "make"
> hangs simply in D state:
> 
> # ps aux | grep make
> user 7177 0.0  0.0 1984 760 pts/1 D+ 16:13 0:00 make -f myMakefile

I have upgraded to kernel 2.6.15 and it could not reproduce the problem 
since.

Is it an effect of nfs-fix-client-hang-due-to-race-condition.patch?
