Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSDCGaS>; Wed, 3 Apr 2002 01:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313074AbSDCGaI>; Wed, 3 Apr 2002 01:30:08 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:59384 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313070AbSDCG3v>; Wed, 3 Apr 2002 01:29:51 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 2 Apr 2002 23:28:24 -0700
To: Aryojan - <aryojan@linuxfreemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c <- Thanks for your support
Message-ID: <20020403062824.GP4735@turbolinux.com>
Mail-Followup-To: Aryojan - <aryojan@linuxfreemail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204030541.g335f3a21868@superglide.netfx-2000.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 02, 2002  21:41 -0800, Aryojan - wrote:
> Mar  1 01:57:43 gnet kernel: kernel BUG at slab.c:1248!
> Mar  1 01:57:43 gnet kernel: invalid operand: 0000
> Mar  1 01:57:43 gnet kernel: CPU:    0
> Mar  1 01:57:43 gnet kernel: EIP:    0010:[<c0129133>]    Tainted: P 
> Mar  1 01:57:43 gnet kernel: EFLAGS: 00210082
> Mar  1 01:57:43 gnet kernel: eax: 0000001b   ebx: c0c03658   ecx: c02ac880   edx: 0000169b
> Mar  1 01:57:43 gnet kernel: esi: c12031d0   edi: c0c0369b   ebp: c0c0369b   esp: c16ade1c
> Mar  1 01:57:43 gnet kernel: ds: 0018   es: 0018   ss: 0018
> Mar  1 01:57:43 gnet kernel: Process kdeinit (pid: 396, stackpage=c16ad000)
> Mar  1 01:57:43 gnet kernel: Stack: c025beca 000004e0 00000000 c1203500 000001f0 000001f0 00000040 00200246
> Mar  1 01:57:43 gnet kernel:        c0128d07 c12031d0 000001f0 c1203500 c1203508 000001f0 00000000 c0208816
> Mar  1 01:57:43 gnet kernel:        00000200 c1a59e00 c1203510 00000008 00000001 c1a58000 c012935c c1203500 
> Mar  1 01:57:43 gnet kernel: Call Trace: [<c0128d07>] [<c0208816>] [<c012935c>] [<c0208c0a>] [<c0208160>]
> Mar  1 01:57:43 gnet kernel:    [<c02082cc>] [<c02416d0>] [<c0205cd9>] [<c0205f1e>] [<c012ffc6>] [<c0106c6b>] 
> Mar  1 01:57:43 gnet kernel:
> Mar  1 01:57:43 gnet kernel: Code: 0f 0b 83 c4 08 ba a5 c2 0f 17 89 d8 03 46 18 87 50 fc 81 fa
> Mar  1 01:58:06 gnet kernel:  <6>NVRM: AGPGART: freed 16 pages
> Mar  1 01:58:06 gnet kernel: NVRM: AGPGART: backend released

You need to run this through ksymoops to be at all useful.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

