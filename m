Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315815AbSEJFye>; Fri, 10 May 2002 01:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315816AbSEJFyd>; Fri, 10 May 2002 01:54:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62727 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315815AbSEJFyc>; Fri, 10 May 2002 01:54:32 -0400
Message-ID: <3CDB51D6.8000302@evision-ventures.com>
Date: Fri, 10 May 2002 06:51:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Peter Chubb napisa?:
> Hi,
> 	At present, linux is limited to 2TB filesystems even on 64-bit
> systems, because there are various places where the block offset on
> disc are assigned to unsigned or int 32-bit variables.
> 
> There's a type, sector_t, that's meant to hold offsets in sectors and
> blocks.  It's not used consistently (yet).
> 

The IDE part of it appears to be sane. I will take it.

