Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313966AbSDPXoG>; Tue, 16 Apr 2002 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313967AbSDPXoF>; Tue, 16 Apr 2002 19:44:05 -0400
Received: from smtp3.wanadoo.es ([62.37.236.137]:7321 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S313966AbSDPXoE>;
	Tue, 16 Apr 2002 19:44:04 -0400
Message-Id: <200204162332.g3GNW4u25399@smtp.wanadoo.es>
Content-Type: text/plain; charset=US-ASCII
From: Jacek Boboli <hussaile@ant.pl>
To: linux-kernel@vger.kernel.org
Subject: kernel-2.4.19pre7
Date: Wed, 17 Apr 2002 01:45:54 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Got no problem formerly with pre3 but now have problems with make bzImage and 
make install, just when finalizing.

.....
.....
	--end-group \
	-o vmlinux
fs/fs.o: In function 'create_data_partitions' ......
fs/fs.o(.text+0x23101):undefined reference to 'page_cache_release'
.....
......
the same with 'get_disk_objid' and finally :
more undefined references to 'page_cache_release' follow
make:***[vmlinux]Error1

then bash again. no bzImage is created.
modules seems OK.

