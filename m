Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSBZQiH>; Tue, 26 Feb 2002 11:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291084AbSBZQh5>; Tue, 26 Feb 2002 11:37:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64261 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291081AbSBZQhm>; Tue, 26 Feb 2002 11:37:42 -0500
Message-ID: <3C7BB9A3.30408@evision-ventures.com>
Date: Tue, 26 Feb 2002 17:36:51 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> True, and it could to tricks like listing space used for undelete as "free"
> in addition to dynamic garbage collection.
> 
> Though, with a daemon checking the dirs often, or using Daniel's idea of a
> socket between unlink() in glibc and an undelete daemon could work quite
> similairly.
> 
> Also, there wouldn't be any interaction with filesystem internals, and
> userspace would probably work better with non-posix type filesystems (vfat,
> hfs, etc) too.
> 
> IOW, there seems to be little gain to having an kernelspace solution.
>

IMNSHO everyone thinking about undeletion in Linux should be
sentenced to 1 year of VMS usage and asked then again if he
still think's that it's a good idea...

