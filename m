Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316979AbSFKJnA>; Tue, 11 Jun 2002 05:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFKJm7>; Tue, 11 Jun 2002 05:42:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45328 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316979AbSFKJm6> convert rfc822-to-8bit; Tue, 11 Jun 2002 05:42:58 -0400
Message-ID: <3D05C61B.1090809@evision-ventures.com>
Date: Tue, 11 Jun 2002 11:42:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com> <20020611092637.C1346@flint.arm.linux.org.uk> <3D05B61F.4010609@evision-ventures.com> <20020611100634.D1346@flint.arm.linux.org.uk> <3D05BE5B.1000705@evision-ventures.com> <20020611102859.F1346@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Russell King napisa³:
> On Tue, Jun 11, 2002 at 11:09:47AM +0200, Martin Dalecki wrote:
> 
>>U¿ytkownik Russell King napisa³:
>>
>>>GCC 3.x introduces the dodgy practice of removing the frame pointer
>>>from every function despite telling the compiler not to with
>>>-fno-omit-frame-pointer.  It's also contary to the GCC documentation
>>>when it interferes with debugging.
>>
>>This can not be true - since otherwise task switching wouldn't work
>>at all!
> 
> 
> It is indeed true.  From your comment, it looks like you don't understand
> the ARM architecture/what a frame pointer is.

Well I surely understand what a pointer to the local variable set is.
I know pascal and gdb well enough :-). However what I may have
missed is that ARM is using some other task switch mechanism.
I would be courious to see what it is?

