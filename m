Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265704AbSJTAIF>; Sat, 19 Oct 2002 20:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265707AbSJTAIF>; Sat, 19 Oct 2002 20:08:05 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:64916 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S265704AbSJTAIE>; Sat, 19 Oct 2002 20:08:04 -0400
Message-ID: <3DB1F55E.2060501@quark.didntduck.org>
Date: Sat, 19 Oct 2002 20:14:22 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
References: <Pine.LNX.4.10.10210191627090.24031-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
>>Copy-protected discs abuse the CD standards to the point where CDROM
>>drives consider them defective and can't/won't read them, while less
>>intelligent devices can.  Trying to read one of these discs should only
>>cause the kernel to return an error, never an oops.
> 
> 
> You admit that older dumber devices just work.
> So much for new and improved, go find the old and lousy that works.

Audio-only CD players are cheap and dumb.  The standard audio CD format 
is not complex, and certain parts of the disc that are needed for data 
CDs are ignored by audio players.  This is where the copy-protected 
discs use false data to confuse CDROM drives.

> Asking me to make it so you or anyone else can bypass
> copy-content-protection is out of the question.  If you do not ask the
> device to do bad things, then it will not do bad things back at you.

Nobody asked you to bypass the protection, only to sanely error out when 
it is found.  Refusing to read the disk is ok, but allowing the system 
to crash is not.

--
				Brian Gerst

