Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136505AbREJNte>; Thu, 10 May 2001 09:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136591AbREJNtY>; Thu, 10 May 2001 09:49:24 -0400
Received: from Mail.oeone.com ([216.221.199.131]:37133 "HELO mail.oeone.com")
	by vger.kernel.org with SMTP id <S136505AbREJNtT>;
	Thu, 10 May 2001 09:49:19 -0400
Message-ID: <3AFA9D88.A97ED135@oeone.com>
Date: Thu, 10 May 2001 09:54:16 -0400
From: Masoud Sharabiani <masouds@oeone.com>
Organization: OEone corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Blanke <blanke@ddd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiler-Error
In-Reply-To: <01051016444800.11128@php-tux>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Pls. send your .config file as well, along with architecture (and
compiler/glibc/distribution name and version).

Masoud.
(It enables everyone to reproduce the problem).
Nico Blanke wrote:
> 
> Hi there !
> 
> I'm not able to compile linux 2.4.4, because i get the following
> compiler-error :
> 
> buz.c: In function `v4l_fbuffer_alloc':
> buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> buz.c:188: (Each undeclared identifier is reported only once
> buz.c:188: for each function it appears in.)
> buz.c: In function `jpg_fbuffer_alloc':


> buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> buz.c:256: warning: `alloc_contig' might be used uninitialized in this
> function
> buz.c: In function `jpg_fbuffer_free':
> buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> buz.c:316: warning: `alloc_contig' might be used uninitialized in this
> function
> buz.c: In function `zoran_ioctl':
> buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> make[3]: *** [buz.o] Error 1
> make[3]: Leaving directory `/home/blanke/linux/drivers/media/video'
> make[2]: *** [_modsubdir_video] Error 2
> make[2]: Leaving directory `/home/blanke/linux/drivers/media'
> make[1]: *** [_modsubdir_media] Error 2
> make[1]: Leaving directory `/home/blanke/linux/drivers'
> make: *** [_mod_drivers] Error 2
> 
> --
>         Best regards,
> 
>                 Nico Blanke
> 
> --
> DDD Design                              Fon :   ++49 40 27 88 37-0
> Gesellschaft für Multimedia mbH         Fax :   ++49 40 27 88 37-300
> Jarrestrasse 46                         eMail:  blanke@ddd.de
> 22303 Hamburg                           http://www.ddd.de
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
