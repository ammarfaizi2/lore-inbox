Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDMRat (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 13:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDMRas (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 13:30:48 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:30943 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S263473AbTDMRar (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 13:30:47 -0400
Message-ID: <3E99A1E4.30904@hccnet.nl>
Date: Sun, 13 Apr 2003 19:44:04 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl>	 <1050172083.2291.459.camel@localhost>  <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>So your zip drive most likely works fine.
>
>  
>
Doesn't look like it works, the mount process gets stuck:

[root@viper root]# mount -t ext2 /dev/sda1 /mnt/zip
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through

At this point the mount process is unkillable.


    Gert


