Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287159AbSAECIp>; Fri, 4 Jan 2002 21:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbSAECIf>; Fri, 4 Jan 2002 21:08:35 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:27915 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S287159AbSAECIR>;
	Fri, 4 Jan 2002 21:08:17 -0500
Message-ID: <3C366013.6090207@blueyonder.co.uk>
Date: Sat, 05 Jan 2002 02:08:19 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.5.1-dj11/12 compile errors
Content-Type: multipart/mixed;
 boundary="------------010204050004080200090706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204050004080200090706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

bumble:~ # gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.3/specs
gcc version 2.95.3 20010315 (SuSE)
	See attached.
Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

--------------010204050004080200090706
Content-Type: text/plain;
 name="dj11_12_err"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dj11_12_err"

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -c -o init/do_mounts.o init/do_mounts.c
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

--------------010204050004080200090706--

