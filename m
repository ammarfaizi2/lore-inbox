Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSE3VNq>; Thu, 30 May 2002 17:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316881AbSE3VNp>; Thu, 30 May 2002 17:13:45 -0400
Received: from web14902.mail.yahoo.com ([216.136.225.54]:10392 "HELO
	web14902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316878AbSE3VNo>; Thu, 30 May 2002 17:13:44 -0400
Message-ID: <20020530211343.15963.qmail@web14902.mail.yahoo.com>
Date: Thu, 30 May 2002 17:13:43 -0400 (EDT)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: about genksyms
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, I want to make some specific .ver
archives for my module. I use the following command.

gcc -E -D__GENKSYMS__ main.c | genksyms -k 2.4.7 >
main.ver

I can create the main.ver file. But when I build my
module with this .ver file I couldn't load the module
into the kernel using the insmod command. It said that
the there are some unresolved symbols in my module. I
think it is a problem of kernel version confliction.
My linux is RedHat Linux 7.2 and the kernel version is
2.4.7-10. How can I specify this kernel function in
the genksyms command line?

Thank you very much.



______________________________________________________________________ 
Find, Connect, Date! http://personals.yahoo.ca
