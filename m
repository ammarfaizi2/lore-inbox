Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSDJK11>; Wed, 10 Apr 2002 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDJK10>; Wed, 10 Apr 2002 06:27:26 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20747 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312392AbSDJK1Z>;
	Wed, 10 Apr 2002 06:27:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jurgen Philippaerts <jurgen@pophost.eunet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c 
In-Reply-To: Your message of "Tue, 09 Apr 2002 23:47:34 +0200."
             <20020409214734.GL9996@sparkie.is.traumatized.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 20:27:08 +1000
Message-ID: <5494.1018434428@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002 23:47:34 +0200, 
Jurgen Philippaerts <jurgen@pophost.eunet.be> wrote:
>gcc io.o ksyms.o ksymoops.o map.o misc.o object.o oops.o re.o
>symbol.o -Dlinux -Wall -Wno-conversion -Waggregate-return
>-Wstrict-prototypes -Wmissing-prototypes  -DDEF_KSYMS=\"/proc/ksyms\"
>-DDEF_LSMOD=\"/proc/modules\" -DDEF_OBJECTS=\"/lib/modules/*r/\"
>-DDEF_MAP=\"/usr/src/linux/System.map\" -Wl,-Bstatic -lbfd -liberty
>-Wl,-Bdynamic -o ksymoops
>/usr/lib/libbfd.a(merge.o): In function `merge_strings':
>merge.o(.text+0xc04): undefined reference to `htab_create'
>merge.o(.text+0xc2c): undefined reference to `htab_create'

http://marc.theaimsgroup.com/?l=linux-kernel&m=101773461204829&w=2

