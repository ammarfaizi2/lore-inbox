Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbSLKTQH>; Wed, 11 Dec 2002 14:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbSLKTQH>; Wed, 11 Dec 2002 14:16:07 -0500
Received: from ns.aspic.com ([213.193.2.5]:11013 "EHLO off.aspic.com")
	by vger.kernel.org with ESMTP id <S267289AbSLKTQC>;
	Wed, 11 Dec 2002 14:16:02 -0500
Date: Wed, 11 Dec 2002 20:23:42 +0100
From: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>
To: eric lin <fsshl@centurytel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you successful compile or install 2.5.50?
Message-Id: <20021211202342.5285bbbe.philippe.gramoulle@mmania.com>
In-Reply-To: <3DF5EC8E.9050603@centurytel.net>
References: <3DF5EC8E.9050603@centurytel.net>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.6claws100 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002 06:30:54 -0700
eric lin <fsshl@centurytel.net> wrote:


You might want to give 2.5.51 a try as i successfully buit it and modules have been working fine
(you need latest modules tools found here:

  | On Tue, 10 Dec 2002 18:04:27 +1100
  | Rusty Russell <rusty@rustcorp.com.au> wrote:

  |  Hi all,
  |  
  |  	module-init-tools 0.9.3 and the associated RPM
  |  modutils-2.4.21-7.src.rpm are out.
  |  
  |  	http://www.[CC].kernel.org/pub/linux/kernel/people/rusty/modules/

Bye

Philippe.

# uname -a
Linux test 2.5.51 #5 SMP Wed Dec 11 19:05:40 CET 2002 i686 unknown unknown GNU/Linux

# lsmod

Module                  Size  Used by
dummy                   1720  1
hid                    21186  0
sb_lib                 43181  0 [permanent]
uart401                 8461  1 sb_lib
sound                  74003  2 sb_lib uart401
uhci_hcd               27941  0
usbcore                88471  4 hid uhci_hcd
nls_utf8                1230  0
smbfs                  58934  0
ymfpci                 46876  0
ac97_codec             11702  1 ymfpci [permanent]
soundcore               6306  3 sb_lib sound ymfpci
nfs                   122403  0
nfsd                  112661  0
exportfs                4558  1 nfsd [permanent]
lockd                  58356  2 nfs nfsd
sunrpc                101860  3 nfs nfsd lockd


  |  
  |     I just wonder how do you successful compile or install that 2.5.50? 
  |  do you meet error at make modules?  if yes, how do you do ?(modify by 
  |  yourself or postto author or public waiting for reply?)
  |  
  |     highly appreciate your experience on compile or install new kernel 
  |  especailly experiamental kernel
  |  
  |  sincere ERic
  |  www.linuxspice.com
  |  linux pc for sale
  |  
  |  -
  |  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
  |  the body of a message to majordomo@vger.kernel.org
  |  More majordomo info at  http://vger.kernel.org/majordomo-info.html
  |  Please read the FAQ at  http://www.tux.org/lkml/
  |  
