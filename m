Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUAOXAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUAOXAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:00:07 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21984 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263777AbUAOW7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:59:45 -0500
Message-ID: <40071B5B.80708@namesys.com>
Date: Fri, 16 Jan 2004 01:59:39 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jari Ruusu <jariruusu@users.sourceforge.net>
CC: Jim Faulkner <jfaulkne@ccs.neu.edu>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>		 <4006C665.3065DFA1@users.sourceforge.net> <Pine.GSO.4.58.0401151215320.27227@denali.ccs.neu.edu> <4006F915.370357A9@users.sourceforge.net>
In-Reply-To: <4006F915.370357A9@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:

>
>  
>
>>Also, in the loop-AES.README, this is mentioned:
>>
>>"Device backed loop device can be used with journaling file systems as
>>device backed loops guarantee that writes reach disk platters in
>>order required by journaling file system (write caching must be disabled
>>on the disk drive, of course)"
>>
>>Are you talking about the "hdparm -W" flag for IDE drives?
>>    
>>
>
>Yes.
>
>If you don't have UPS powered box, disabling write caching of disks is
>recommended when using journaling file system.
>  
>
unless you use the write cache flushing code which went into a kernel 
version I can never remember.....


-- 
Hans


