Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbSJaWAJ>; Thu, 31 Oct 2002 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSJaWAJ>; Thu, 31 Oct 2002 17:00:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21777 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265379AbSJaWAD>;
	Thu, 31 Oct 2002 17:00:03 -0500
Message-ID: <3DC1A925.1000703@pobox.com>
Date: Thu, 31 Oct 2002 17:05:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: David Lang <david.lang@digitalinsight.com>,
       "David C. Hansen" <haveblue@us.ibm.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reiser vs EXT3
References: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com> <3DC1A5D5.8000901@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> If you want to talk about 2.6 then you should talk about reiser4 not 
> reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 
> for 30 copies of the linux kernel source code using modern IDE drives 
> and modern processors on a dual-CPU box, so I don't think any amount 
> of improved scalability will make ext3 competitive with reiser4 for 
> performance usages. 


What is the read performance like?

write performance isn't the end-all be-all of useful benchmarks, because 
most servers do far more reading in a day than they will ever write. 
 And like Andrew has pointed out on more than one occasion, reads are 
usually synchronous, because applications are typically blocking until 
each read is satisfied.

    Jeff




