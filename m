Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291066AbSBLOJo>; Tue, 12 Feb 2002 09:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291062AbSBLOJ3>; Tue, 12 Feb 2002 09:09:29 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:64975 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S291065AbSBLOJQ>; Tue, 12 Feb 2002 09:09:16 -0500
Message-ID: <3C6920A7.2080002@antefacto.com>
Date: Tue, 12 Feb 2002 14:03:19 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davidovac Zoran <zdavid@unicef.org.yu>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And a patch to call it automatically:
http://www.tpgn.net/exploits/linux/secrm.kernel.patch.2.2.14.txt

On a related note is there any way to clear the unused portion
of the last block of a file. Obviously it's file system dependent,
but what happens in general on ext2?

Padraig.

Davidovac Zoran wrote:
> there is srm (secure rm) somewhere on the net
> here srm.sourceforge.net
> srm - secure file deletion for posix systems
> 
> happy srm,
> 
>       Zoran
> 
>    srm is a secure replacement for rm(1). Unlike the standard rm, it
>    overwrites the data in the target files before unlinking them. This
>    prevents command-line recovery of the data by examining the raw block
>    device. It may also help frustrate physical examination of the disk,
>    although it's unlikely that it can completely prevent that type of
>    recovery. It is, essentially, a paper shredder for sensitive files.
> 
>    srm is ideal for personal computers or workstations with Internet
>    connections. It can help prevent malicious users from breaking in and
>    undeleting personal files, such as old emails. It's also useful for
>    permanently removing files from expensive media. For example, cleaning
>    your diary off the zip disk you're using to send vacation pictures to
>    Uncle Lou. Because it uses the exact same options as rm(1), srm is
>    simple to use. Just subsitute it for rm whenever you want to destroy
>    files, rather than just unlinking them.
> 
> 
> On Tue, 12 Feb 2002, Roy Sigurd Karlsbakk wrote:
> 
> 
>>Date: Tue, 12 Feb 2002 14:12:49 +0100 (CET)
>>From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
>>To: linux-kernel@vger.kernel.org
>>Subject: secure erasure of files?
>>
>>hi all
>>
>>Does anyone know if it'll be hard to enable a <em>secure</em> deletion of
>>files? What I mean is not merely overwriting it with NULLs, but rather
>>using a more sophisticated overwrite, like the IBAS ExpertEraser software
>>(http://www.ibas.com/erasure/)
>>
>>Is this hard/possible/doable?
>>
>>roy


