Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313970AbSDPXzx>; Tue, 16 Apr 2002 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313971AbSDPXzw>; Tue, 16 Apr 2002 19:55:52 -0400
Received: from jalon.able.es ([212.97.163.2]:62169 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313970AbSDPXzv>;
	Tue, 16 Apr 2002 19:55:51 -0400
Date: Wed, 17 Apr 2002 01:55:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jacek Boboli <hussaile@ant.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.19pre7
Message-ID: <20020416235544.GA1800@werewolf.able.es>
In-Reply-To: <200204162332.g3GNW4u25399@smtp.wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.17 Jacek Boboli wrote:
>Hello !
>
>Got no problem formerly with pre3 but now have problems with make bzImage and 
>make install, just when finalizing.
>
>.....
>.....
>	--end-group \
>	-o vmlinux
>fs/fs.o: In function 'create_data_partitions' ......
>fs/fs.o(.text+0x23101):undefined reference to 'page_cache_release'
>.....
>......
>the same with 'get_disk_objid' and finally :
>more undefined references to 'page_cache_release' follow
>make:***[vmlinux]Error1
>
>then bash again. no bzImage is created.
>modules seems OK.
>

Apply this:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre7-jam1/04-fs-pagemap.gz

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam1 #1 SMP Wed Apr 17 00:42:27 CEST 2002 i686
