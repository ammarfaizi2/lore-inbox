Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSETTl0>; Mon, 20 May 2002 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316300AbSETTl0>; Mon, 20 May 2002 15:41:26 -0400
Received: from adsl-65-67-113-206.dsl.rcsntx.swbell.net ([65.67.113.206]:13444
	"HELO ansivirus.mine.nu") by vger.kernel.org with SMTP
	id <S316289AbSETTlY>; Mon, 20 May 2002 15:41:24 -0400
Subject: Problem with 2.4.18 kernel downloaded from kernel.org
From: Mike Ramsey <mramsey@ansivirus.mine.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 May 2002 14:37:48 -0500
Message-Id: <1021923468.22591.7.camel@ansivirus.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

during make modules it fails with

make[1]: Entering directory `/usr/src/linux-2.4.18-6mdk/drivers'
make -C atm modules
make[2]: Entering directory `/usr/src/linux-2.4.18-6mdk/drivers/atm'
make[2]: *** No rule to make target
`/home/quintela/rpm/2418/BUILD/linux/include/linux/module.h', needed by
`eni.o'.  Stop.
make[2]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers/atm'
make[1]: *** [_modsubdir_atm] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers'
make: *** [_mod_drivers] Error 2

well as you can see there is a problem here.. The fact that quintela is
not a user on my system and i believe juan quintela to be a kernel
developer. I could be wrong here. anyway i decided to perform a grep -r
quintela /usr/src/linux/* > output.txt it generated a 3MB  txt file i'm 
not attaching as of yet do to its size. if you would like it let me
know. Otherwise please have this hard linked directory removed  from the
source so i don't need to compile  from that dirctory :P 

Thanks 
Mike Ramsey

