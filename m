Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSEUS5i>; Tue, 21 May 2002 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEUS5h>; Tue, 21 May 2002 14:57:37 -0400
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:59103 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315442AbSEUS5f>; Tue, 21 May 2002 14:57:35 -0400
Date: Tue, 21 May 2002 20:18:14 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] scheduler utilities
Message-ID: <20020521181814.GA459@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1021999069.2638.36.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.1i (Linux 2.4.19-pre8-ac5 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert!

On Tue May 21 2002, Robert Love wrote:

> source tarball:  http://tech9.net/rml/schedutils-0.0.5.tar.gz

This doesn't compile:

chiara:/Src/schedutils-0.0.5 # make
gcc -Wall -Wstrict-prototypes -O2 -o taskset taskset.c
taskset.c: In function main':
taskset.c:97: warning: implicit declaration of function sched_getaffinity'
taskset.c:110: warning: implicit declaration of function sched_setaffinity'
/tmp/ccgxCHEH.o: In function main':
/tmp/ccgxCHEH.o(.text+0x1ac): undefined reference to sched_getaffinity'
/tmp/ccgxCHEH.o(.text+0x1fe): undefined reference to sched_setaffinity'
/tmp/ccgxCHEH.o(.text+0x23f): undefined reference to sched_getaffinity'
collect2: ld returned 1 exit status
make: *** [taskset] Error 1
chiara:/Src/schedutils-0.0.5 #

Kernel is 2.4.19-pre8-ac5 with the related patches.

Greetings, Heinz.
-- 
# Heinz Diehl, 68259 Mannheim, Germany
