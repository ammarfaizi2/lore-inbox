Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292334AbSBPJkP>; Sat, 16 Feb 2002 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292342AbSBPJkI>; Sat, 16 Feb 2002 04:40:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16911 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292334AbSBPJjw>; Sat, 16 Feb 2002 04:39:52 -0500
Message-ID: <3C6E28D3.9070902@evision-ventures.com>
Date: Sat, 16 Feb 2002 10:39:31 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE cleanup for 2.5.4-pre3
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com> <20020215204510.GD5019@atrey.karlin.mff.cuni.cz> <20020215222432.A7631@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Fri, Feb 15, 2002 at 09:45:10PM +0100, Pavel Machek wrote:
>
>>My favourite cleanup would be 
>>
>>struct ide_drive_s {} ide_drive_t;
>>
>>=>
>>
>>struct ide_drive {};
>>
>>and replacing all ide_drive_t with struct ide_drive...
>>
>
>Well, my favorite would be to kill HWIF() ...
>
That's on target already (half gone in my private code).
Look at ide_module_t to se some other invention for the sake of it.

>
>



