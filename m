Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSFGNp3>; Fri, 7 Jun 2002 09:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317285AbSFGNp2>; Fri, 7 Jun 2002 09:45:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17425 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317283AbSFGNp2>; Fri, 7 Jun 2002 09:45:28 -0400
Message-ID: <3D00AB3B.9020201@evision-ventures.com>
Date: Fri, 07 Jun 2002 14:46:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "goggin, edward" <egoggin@emc.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Request to have get_blkfops() and get_chrfops() exported to kerne
 l modules
In-Reply-To: <64655AAA92E6ED46B9AC9421260D96A5D18BF4@srmanning.eng.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

goggin, edward wrote:
> This is a request to have both the linux kernel symbols
> get_chrfops and get_blkfops exported to kernel modules
> in future releases of the linux kernel.
> 
> This request is in response to a need we have when building
> kernel modules which will filter block and/or character device
> i/o by trapping the native block/character i/o requests.


The loop device implementation is showing you already
how to achieve this.

