Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291560AbSBHMfc>; Fri, 8 Feb 2002 07:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291562AbSBHMfW>; Fri, 8 Feb 2002 07:35:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1296 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291560AbSBHMfF>;
	Fri, 8 Feb 2002 07:35:05 -0500
Message-ID: <3C63C5EF.4050403@evision-ventures.com>
Date: Fri, 08 Feb 2002 13:34:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020129
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
        vojtech@ucw.cz, andre@linuxdiskcert.org
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>IDE is
>* infested with polish notation
>
I don't see any polish notation there. Could you please explain what you 
mean with this note?
Other then this - the patch does good.... BTW. There is the issue of 
multiple
block strategy routines in ide-disk.c and the selection of 16 ver. 32 
bit transfers could
be simplified as well, since the particular code in question is 
blatantly over-optimized.



