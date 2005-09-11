Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVIKQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVIKQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVIKQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:33:59 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:61569 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S1751034AbVIKQd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:33:58 -0400
Message-ID: <43245C56.5000905@jg555.com>
Date: Sun, 11 Sep 2005 09:33:26 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com> <20050910.010114.28468998.davem@davemloft.net>
In-Reply-To: <20050910.010114.28468998.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>You can make SILO 64-bit, but it would just be a lot
>of work and would just result in a SILO that, unlike
>current SILO, would only work on UltraSPARC machines.
>
>There really is no advantage, and known disadvantages, to
>making SILO 64-bit.
>  
>
If I have a system that is a Pure64 environment, I try to compile Silo, 
it will not function. Since there is no support for 32 bit, how would I 
be able to use it.

Isn't there a way to compile the programs necessary as 64bit but the 
actual mbr or .b files depending on your architecture be 32 bit. I

In the case of Silo, it compiles, but when you run silo -f, when you 
reboot, it Starts Silo, then gives, Program Terminiated in OBP. Which 
now makes the computer useless, unless you have a 32 bit build of silo 
standing around.

Also in the case of Silo, if you try to compile it on a modern tool 
chain, the .b files it generates don't work, which I have reported 
upstream. Modern toolchain = binutils 2.16.1, gcc 3.4.4, and glibc 2.3.5.

For the Sparc64 builds, I'm starting to look at using OBP to do the booting.

-- 
----
Jim Gifford
maillist@jg555.com

