Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSFWLFh>; Sun, 23 Jun 2002 07:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSFWLFg>; Sun, 23 Jun 2002 07:05:36 -0400
Received: from [213.4.129.129] ([213.4.129.129]:27841 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id <S317004AbSFWLFg>;
	Sun, 23 Jun 2002 07:05:36 -0400
Date: Sun, 23 Jun 2002 13:07:25 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-Id: <20020623130725.7e0176a8.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002 22:13:52 -0300 (BRT)
Alexandre Pereira Nunes <alex@PolesApart.dhs.org> escribió:
> 
> kernel BUG at page_alloc.c:131!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c014177e>]    Tainted: P
> EFLAGS: 00010286
> eax: cba53f48   ebx: c144955c   ecx: c025f6dc   edx: 00000000
> esi: 00000000   edi: 138de070   ebp: 00001000   esp: c41b7ec8
> ds: 0018   es: 0018   ss: 0018
> Process X (pid: 3924, stackpage=c41b7000)
> Stack: c144955c c0142fca c02ba2a0 00000000 00000001 c144955c 00000000
> 138de070
>        d38de070 00000000 138de070 00001000 c01351c6 c144955c 0000000e
> d2fca688
>        0000000e 00000001 40400000 cd841404 4001d000 00000000 c013320b
> d5decd40
> Call Trace: [<c0142fca>] [<c01351c6>] [<c013320b>] [<c01367a1>]
> [<c01368ca>]
>    [<c010ba0f>]
> 
> Code: 0f 0b 83 00 53 b0 23 c0 8b 43 18 c6 43 24 05 89 f1 89 dd 83
>  <3>X[3924] exited with preempt_count 1

It'd be nice if you could pass this oops throught ksymoops....
