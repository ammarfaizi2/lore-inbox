Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267882AbTAHTwH>; Wed, 8 Jan 2003 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTAHTvn>; Wed, 8 Jan 2003 14:51:43 -0500
Received: from Milligan.cwx.net ([216.17.176.90]:30359 "EHLO mail.acmeps.com")
	by vger.kernel.org with ESMTP id <S267882AbTAHTvh>;
	Wed, 8 Jan 2003 14:51:37 -0500
Message-ID: <3E1C8350.3010804@acmeps.com>
Date: Wed, 08 Jan 2003 13:00:16 -0700
From: Michael Milligan <milli@acmeps.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
Cc: Max Valdez <maxvaldez@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
References: <200301070859.h078xEnI000337@darkstar.example.net>
In-Reply-To: <200301070859.h078xEnI000337@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>Is there any way to revert the stupid mistyping of "rm file *" on ext3??
> 
> There is no simple way, no.
> 
>>I hope there is a way, because I dont have a backup of some files i
>>mistakenly deleted
> 
> The only thing I can suggest is this:
> 
> * Do not write anything else to the partition, and immediately
>   re-mount it read-only.
> 
> E.G.:
> 
> mount -oremount -oro /dev/hda3
> 
> * Use dd to copy the entire contents of the partition to a file on
>   another partition.
> 
> E.G.:
> 
> dd if=/dev/hda3 of=/partition_image
> 
> * Search through that file for the fragments of your lost files.
> 

This is where Lazarus from The Coroner's Toolkit might come in handy. 
It's designed for ext2 though, not ext3, but it might work for you 
nonetheless since ext3 is basically built on top of ext2.

http://www.cert.org/security-improvement/implementations/i046.03.html

Regards,
Mike

-- 
Michael Milligan  --  Free Agent  --  milli@acmeps.com

