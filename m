Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSIZJsa>; Thu, 26 Sep 2002 05:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbSIZJs3>; Thu, 26 Sep 2002 05:48:29 -0400
Received: from [203.117.131.12] ([203.117.131.12]:15058 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262266AbSIZJs3>; Thu, 26 Sep 2002 05:48:29 -0400
Message-ID: <3D92D922.5000606@metaparadigm.com>
Date: Thu, 26 Sep 2002 17:53:38 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table,  unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com> <20020926092152.GA32593@danielle.hinet.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/02 17:21, Mario Mikocevic wrote:
[snip]
>>So, is possible for qlogic driver to be doing naughty things
>>with bufferheads? or is it more likely in the fs?
>>
>>Anyone out there running a reasonably busy fileserver with
>>qlogic FC HBA and using ext3 or XFS with quotas? What
>>kernel/qlogic driver combo?
> 
> 
> # w
>  11:06am  up 159 days, 12:01,  1 user,  load average: 4.22, 3.41, 3.53
> # uname -r
> 2.4.18

I wish i had that uptime - reminds me of my 2.2.x boxes
(although they don't have ext3 or qlogic HBAs).

> ext3 partition on SAN connected through _two_ qla2200 HBAs and onto _two_
> FC switches with qla2200phase1.tar.gz driver from Arjan van de Ven.
> (the _only_ driver that works with MULTIPATH)

This linus 2.4.18? just with qlogic driver added?

I wonder if LVM has anything to do with my problems,
you using quotas or LVM?

Also I wonder if the file access pattern of 'afpd' (the offending
process in my oops) triggers some problem not usually observed.

~mc

