Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSFEOAS>; Wed, 5 Jun 2002 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSFEOAR>; Wed, 5 Jun 2002 10:00:17 -0400
Received: from smtp2.tivoli.com ([216.140.178.3]:37508 "HELO smtp2.tivoli.com")
	by vger.kernel.org with SMTP id <S314680AbSFEOAQ>;
	Wed, 5 Jun 2002 10:00:16 -0400
Message-ID: <3CFE1998.8000306@tiscalinet.it>
Date: Wed, 05 Jun 2002 16:00:56 +0200
From: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: All In Wonder Radeon and bttv module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tried to use kwintv on my desktop with All in Wonder ATI Radeon AGP.

I have compiled my kernel (2.4.18)  with almost all the video drivers 
compiled as module. The problem is that I have tried to upload the 
module bttv.o using the command

   modprobe bttv

and the following messages have  appeared:

/lib/modules/2.4.18-6mdk/kernel/drivers/media/video/bttv.o.gz: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
modprobe: insmod 
/lib/modules/2.4.18-6mdk/kernel/drivers/media/video/bttv.o.gz failed
modprobe: insmod bttv failed

Can anyone of you help me to understand what is the problem. I think 
that the default IRQ and IO ports are not correct for my video board. If 
so, is it possible have the correct one?

I have tried to search on the Web and in the Linux archives to check if 
these type of errors
have already been solved by someone else, but I haven't found anything.

Thanks in advance for your help.

