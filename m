Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314642AbSEBQjY>; Thu, 2 May 2002 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314647AbSEBQjY>; Thu, 2 May 2002 12:39:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50190 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314642AbSEBQjW>; Thu, 2 May 2002 12:39:22 -0400
Message-ID: <3CD15CFA.1090208@evision-ventures.com>
Date: Thu, 02 May 2002 17:36:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173HX6-00041D-00@the-village.bc.nu>	<3CD13FF3.5020406@evision-ventures.com>	<3CD15996.8EB1699F@redhat.com> <200205021559.g42Fxud19755@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Richard Gooch napisa³:
> Arjan van de Ven writes:
> 
>>someone using perl to replace the built-in kernel version in the .o
>>file)
> 
> 
> Oh, my! Do people really do that?!?

Yes they do, if they wont for example to get some
PCTEL win chip driver working. No matter what Alan and some others
think is good for them :-).

The main problem with mod-versions is the simple fact
that policy doesn't belong in to the kernel it belongs
in the user space. And mod-version is *just policy*.

See... if some impaired project manager at some
linux distro provider associated with hats,
who does decisions like for example basing the main OS
configuration tools on instable programming languages
like python or perl... does decide that he needs
the functionality of MODULEVERSIONS to get full controll about the
users of his crappy product. Why the hell doesn't he let all this
version checking be done for his own kernel cook-up entierly in
his patched mod-utils? And entierly in USER SPACE? He does
have the full scope of things which need the bless of versioning
over them at his hands and there is *no technical* argument why this
should be done in kernel space at all!

It just DOES NOT BELONG in to the kernel-space.

No matter what percentage of supposed problems it solves and
how many problems it in reality adds...

