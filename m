Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTIXXuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTIXXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:50:10 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:39890 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261439AbTIXXuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:50:07 -0400
Message-ID: <3F722C0C.1050901@rackable.com>
Date: Wed, 24 Sep 2003 16:43:08 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Poirier <dave.poirier@atrium.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm3 Promise SuperTrak SX6000 unrecognized
References: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
In-Reply-To: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2003 23:50:06.0173 (UTC) FILETIME=[9483B0D0:01C382F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Poirier wrote:
> I have a Promise SuperTRAK SX6000 IDE RAID controller card which, no
> matter which options are set in the kernel, fail to be recognized.  I
> tried with 2.4.22, 2.6.0-test1..test5 and 2.6.0-test5-mm3, all of which
> simply seems to ignore the card altogether.
> 
> Find attached the `lspci -vxx` output.
> 
> Let me know if you need any testing, I am more than willing to help on
> this.
>


   Have you tried the generic i2o driver?  'Modprobe i2o_scsi'


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

