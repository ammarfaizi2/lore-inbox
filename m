Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSFKJKA>; Tue, 11 Jun 2002 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSFKJJ7>; Tue, 11 Jun 2002 05:09:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23312 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316961AbSFKJJ5> convert rfc822-to-8bit; Tue, 11 Jun 2002 05:09:57 -0400
Message-ID: <3D05BE5B.1000705@evision-ventures.com>
Date: Tue, 11 Jun 2002 11:09:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com> <20020611092637.C1346@flint.arm.linux.org.uk> <3D05B61F.4010609@evision-ventures.com> <20020611100634.D1346@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Russell King napisa³:

> GCC 3.x introduces the dodgy practice of removing the frame pointer
> from every function despite telling the compiler not to with
> -fno-omit-frame-pointer.  It's also contary to the GCC documentation
> when it interferes with debugging.

This can not be true - since otherwise task switching wouldn't work
at all!

