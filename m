Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265530AbRF2Exf>; Fri, 29 Jun 2001 00:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbRF2ExZ>; Fri, 29 Jun 2001 00:53:25 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:50183 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265530AbRF2ExN>; Fri, 29 Jun 2001 00:53:13 -0400
X-Apparently-From: <slamaya@yahoo.com>
Message-ID: <3B3C09E6.2030503@yahoo.com>
Date: Fri, 29 Jun 2001 07:53:58 +0300
From: Yaacov Akiba Slama <slamaya@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010625
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
In-Reply-To: <200106282143.f5SLht624150@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:

>>Hi,
>>
> 
>>So I only hope that the smart guys at SGI find a way to prepare the 
>>patches the way Linus loves because now the file 
>>"patch-2.4.5-xfs-1.0.1-core" (which contains the modifs to the kernel 
>>and not the new files) is about 174090 bytes which is a lot.
>>
>>YA
>>
>>
> 
> But that is not a patch intended for Linus, it is intended to enable all
> the XFS features. I have a couple of kernel patches which total 46298 bytes
> which get you a working XFS filesystem in the kernel, and I could do
> lots of things to make them smaller. When you hit header files in the
> correct manner for different platforms the size tends to mushroom.
> These lines are all in different fcntl.h files for example:
> 
> +#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    0x80000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    0x200000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    0x200000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    0x80000 /* invisible I/O, for DMAPI/XDSM */
> +#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */
> 
> You make the patches look a lot bigger than they really are. There is
> a difference between a patch which is placing things in the correct
> places and one which is designed to be as short as possible.
> 

Agree.
But IMHO, you need to be more "visible" and to already propose those 
kernel modifications - even not the final ones - in lkml in order to let 
everyone see them and change the current think (even by Alan) that XFS 
is too intrusive for 2.4.
There are other people involved in the files you need to change and the 
more your patches are visibles, the more they are "credibles".
I didn't want to critisize XFS (or JFS and ext3) but to give some points 
about their integration in 2.4.
YA


> Steve
> 
> 
> 
> 



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

