Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRCWV7Q>; Fri, 23 Mar 2001 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRCWV7G>; Fri, 23 Mar 2001 16:59:06 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:62297 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S131466AbRCWV6x>;
	Fri, 23 Mar 2001 16:58:53 -0500
Message-ID: <3ABBC7D2.6070502@muppetlabs.com>
Date: Fri, 23 Mar 2001 14:01:54 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-8 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Wesen <bjorn@sparta.lu.se>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: CRAMFS
In-Reply-To: <Pine.LNX.3.96.1010323194500.14171C-100000@medusa.sparta.lu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know why the comparision is made though, they are used for two
> completely different things... ramfs is for temporary file storage, cramfs
> is for immutable files stored on flash. Each by itself is quite optimal
> for what it's designed for, isn't it ?

Exactly. My mistake earlier to assume cramfs was "compressed ramfs"! ;-)
I should compare it to the tar.gz option and JFFS2. Will do in the next 
evaluation.
This will be more of a replace initrd+custom /linuxrc with a 
CRAMFS-based rootfs on a flash device assuming CRAMFS can be directly 
read by kernel\init for getting the rootfs. Ditto for JFFS2

Also, the platform is PPC, IBM 405GP to be precise.

Regards
Amit

