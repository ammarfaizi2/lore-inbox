Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289568AbSBEPFq>; Tue, 5 Feb 2002 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSBEPFg>; Tue, 5 Feb 2002 10:05:36 -0500
Received: from ns2.web-solutions.dk ([212.130.48.54]:34319 "EHLO
	mail.web-solutions.dk") by vger.kernel.org with ESMTP
	id <S289568AbSBEPFX>; Tue, 5 Feb 2002 10:05:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Israel Alvarez <ia@innovatech.dk>
Reply-To: ia@innovatech.dk
Organization: InnovaTech
To: linux-kernel@vger.kernel.org
Subject: can't find module ...
Date: Tue, 5 Feb 2002 16:03:28 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02020516032802.01346@leon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!,
I've just compile the kernel 2.4.17 in my linux 7.2 and installed it in my 
embedded device running 2.2.18. I have followed all the instructions about 
make modules install_modules and so on.
-> I have the modutils 2.1.121.
-> I have the modules in
       /lib/modules/2.2.17/...
-> and I have also updated my modules.conf with the new paths, something like:
      path[drivers]=/lib/modules/2.4.17/kernel/drivers/
      path[net]=/lib/modules/2.4.17/kernel/net/
    and so on

Errors:

-> My modules.dep is empty, and I know I have several dependencies and depmod 
-a is executed while loading.

-> If I use insmod with the absolute path, then it works, but if I try to use 
modprobe, it does not work ( can't locate module...).

-> When I use modprobe -c I get three differents paths for each 
modue:
   path[drivers]=/lib/modules/2.4.17/kernel/drivers/
   ...
   path[drivers]=/lib/modules
   ....
   path[drivers]=/lib/modules/default

So, What happens here? Is there any other file still storing the old paths 
and I should modify it? Are these paths stored in the kernel itself so is 
impossible to change then?

Thanks in advance.
ia
