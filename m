Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSDAQ5v>; Mon, 1 Apr 2002 11:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDAQ5l>; Mon, 1 Apr 2002 11:57:41 -0500
Received: from eccentric.mae.cornell.edu ([128.253.249.157]:38673 "EHLO
	eccentric.mae.cornell.edu") by vger.kernel.org with ESMTP
	id <S312449AbSDAQ5a>; Mon, 1 Apr 2002 11:57:30 -0500
Message-ID: <3CA89159.3070809@mae.cornell.edu>
Date: Mon, 01 Apr 2002 11:56:57 -0500
From: Andrey Klochko <andrey@eccentric.mae.cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: David Christensen <davidc@connect4less.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Modular Frustration w/2.4.18!
In-Reply-To: <3CA411C8.7090701@connect4less.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to do "make dep" and then "make bzImage modules"

Andrey

David Christensen wrote:

> I don't understand it!  I cannot seem to get the modules to compile on 
> my box!  Every time I modify the config to make something compile NOT 
> as a module, the make breaks somewhere else!  ARRRRGHHH!
>
> The lay of the land:
> gcc-cpp-2.96-0.76mdk
> gcc-2.96-0.76mdk
> gcc-c++-2.96-0.76mdk
> libgcc3.0-3.0.4-2mdk 

snip

>
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:78: (Each undeclared 
> identifier is reported only once
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:78: for each function 
> it appears in.)
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
> `free_pgd_fast':
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:89: 
> `boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
> `pte_alloc_one_fast':
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:127: 
> `boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
> `pte_free_fast':
> /usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:137: 
> `boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
> make[2]: *** [floppy.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers'
> make: *** [_mod_drivers] Error 2
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


