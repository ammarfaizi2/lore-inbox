Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287656AbSAFDYu>; Sat, 5 Jan 2002 22:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287626AbSAFDYk>; Sat, 5 Jan 2002 22:24:40 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:45578 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S287649AbSAFDY0>;
	Sat, 5 Jan 2002 22:24:26 -0500
Message-ID: <3C37C36C.5030707@blueyonder.co.uk>
Date: Sun, 06 Jan 2002 03:24:28 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: davej@suse.de
Subject: Re: 2.5.1-dj11/12 compile errors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Disabling initrd still produces an error, but perhaps the fix will 
address this.
Regards

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -c 
-o init/do_mounts.o init/do_mounts.c
init/do_mounts.c: In function `rd_load_disk':
init/do_mounts.c:634: incompatible type for argument 2 of `create_dev'
init/do_mounts.c: In function `handle_initrd':
init/do_mounts.c:752: incompatible type for argument 1 of `kdev_t_to_nr'
init/do_mounts.c:756: incompatible type for argument 2 of `create_dev'
init/do_mounts.c:777: incompatible types in assignment
init/do_mounts.c: In function `initrd_load':
init/do_mounts.c:804: incompatible type for argument 2 of `create_dev'
init/do_mounts.c:805: incompatible type for argument 2 of `create_dev'
init/do_mounts.c: In function `prepare_namespace':
init/do_mounts.c:819: incompatible types in assignment
make: *** [init/do_mounts.o] Error 1

-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

