Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316013AbSENThV>; Tue, 14 May 2002 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316014AbSENThU>; Tue, 14 May 2002 15:37:20 -0400
Received: from relay1.pair.com ([209.68.1.20]:13833 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316013AbSENThT>;
	Tue, 14 May 2002 15:37:19 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CE1684E.7B5CDBD2@kegel.com>
Date: Tue, 14 May 2002 12:41:02 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: blenderman@wanadoo.be,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: SMP problem when compiling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blenderman@wanadoo.be wrote:
> I get this error when I compile the kernel 2.4.18 with make -j (make bzImage)
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> - -Wno-              trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
> - -fno-common -pipe -mpref              erred-stack-boundary=2 -march=i686   
> - -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c               ksyms.c
> cpp0: gcc: Internal compiler error: program cc1 got fatal signal 11

Have you read http://www.bitwizard.nl/sig11/ ?
Are you overclocking?
- Dan
