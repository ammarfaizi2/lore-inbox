Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbTKZU5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTKZU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:57:13 -0500
Received: from imap.gmx.net ([213.165.64.20]:15512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264348AbTKZU5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:57:08 -0500
X-Authenticated: #524548
From: rgx <rgx@gmx.de>
To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
Subject: Re: kernel 2.4-22 won't compile...
Date: Wed, 26 Nov 2003 21:57:05 +0100
User-Agent: KMail/1.5.4
References: <200311261734.23177.rgx@gmx.de> <200311261935.03860.rgx@gmx.de> <1069873394.25657.28.camel@tweedy.ksc.nasa.gov>
In-Reply-To: <1069873394.25657.28.camel@tweedy.ksc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311262157.05035.rgx@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @ll :)

bug fixed, found next:

...

make -C lockd 
make[2]: Entering directory `/data/src/linux-2.4.22/fs/lockd'
make all_targets
make[3]: Entering directory `/data/src/linux-2.4.22/fs/lockd'
gcc -D__KERNEL__ -I/data/src/linux-2.4.22/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=svc4proc  -c -o 
svc4proc.o svc4proc.c
svc4proc.c:564: error: `nlm4svc_decode_void' undeclared here (not in a 
function)
svc4proc.c:564: error: initializer element is not constant
svc4proc.c:564: error: (near initialization for `nlmsvc_procedures4
[0].pc_decode')
...

Further details added to
http://www.lug-owl.de/cgi-bin/wiki/ErrorCompilingKernel20031125

Thanks 4Ur <F1> :)
Ralf

