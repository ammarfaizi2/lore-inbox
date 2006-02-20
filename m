Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWBTFIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWBTFIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWBTFID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:08:03 -0500
Received: from web32107.mail.mud.yahoo.com ([68.142.207.121]:29311 "HELO
	web32107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932624AbWBTFID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:08:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sun/evuH669qBloxcLXJHpIDr3wVAxVZz4roxkbKORPXeGkn101YEhiTharAJu2POjPe08On/nwMS+QnC+Wqbr31847XdiZJwAFq+GR8rVpCSFBT3ngtK0vFdCoZCikFQWj/Mtie1HMIJOzYipO7pTX6naigOeue3+5uu91pUAA=  ;
Message-ID: <20060220050800.4596.qmail@web32107.mail.mud.yahoo.com>
Date: Sun, 19 Feb 2006 21:08:00 -0800 (PST)
From: shivani kirubanandan <k_shivanii@yahoo.com>
Subject: error in compiling ml300 kernel for powerpc-plzzz help another bizzare error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

thanks a ton ..due to ur help i was able to
sucessfully run the make dep on my comuter..if u
remember it cud not find the path then..well now wen i
run my 
make zImage

this is the error i encounter-jus remindin u am tryin
to build a powerpc405 kernel for xilinx ml300

make[3]: Entering directory
`/home/shivani/downloads/linux-2.4.26/drivers/char'
/opt/crosstool/gcc-3.3.2-glibc-2.3.2/powerpc-405-linux-gnu/bin/powerpc-405-linux-gnu-gcc
-D__KERNEL__
-I/home/shivani/downloads/linux-2.4.26/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -fomit-frame-pointer
-I/home/shivani/downloads/linux-2.4.26/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -Wa,-m405  
-nostdinc -iwithprefix include
-DKBUILD_BASENAME=serial  -DEXPORT_SYMTAB -c serial.c
serial.c: In function `start_pci_pnp_board':
serial.c:4039: error: `XPAR_UARTNS550_0_CLOCK_FREQ_HZ'
undeclared (first use in this function)
serial.c:4039: error: (Each undeclared identifier is
reported only once
serial.c:4039: error: for each function it appears
in.)
make[3]: *** [serial.o] Error 1
make[3]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers'
make: *** [_dir_drivers] Error 2

I dont understand by what it means by 'undeclared' as
this parameter has alredy been declared in
/home/arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h

file

plzzz help its urgent

regards and thanks in advance
shivani

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
