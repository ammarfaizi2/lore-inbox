Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTLVAYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTLVAYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 19:24:35 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:25308 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264151AbTLVAYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 19:24:34 -0500
Message-ID: <3FE645E3.30602@rackable.com>
Date: Sun, 21 Dec 2003 17:16:19 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org, linux@3ware.com
Subject: Re: 3ware driver broken with 2.4.22/23 ?
References: <20031221112113.GE916@mail.muni.cz>
In-Reply-To: <20031221112113.GE916@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2003 00:24:33.0411 (UTC) FILETIME=[F9092D30:01C3C821]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> 
> Can firmware upgrade help? Or there is an issue with something other not related
> to 3ware card?
> 

   Generally not with such a small rev difference.  You could try the 
latest driver, and firmware in the 7.7.  The driver source is on the Red 
Hat drivers disk.  You should be able to drop in the .c, and .h in 
drivers/scsi, and recompile.
http://3ware.com/support/download.asp?code=5&id=7.7.0&softtype=Driver&releasenotes=&os=Windows

PS- Personally I'd suspect an XFS bug.  Try reiserfs.  I've been running 
2.4.23pres, and 2.4.23 on hundreds of 3ware of numerous different types. 
  With no issue with the prior firmware release.
-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

