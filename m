Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbREXSmv>; Thu, 24 May 2001 14:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbREXSml>; Thu, 24 May 2001 14:42:41 -0400
Received: from mandy.drsys.net ([64.40.111.212]:2826 "HELO mandy.drsys.net")
	by vger.kernel.org with SMTP id <S262197AbREXSm1>;
	Thu, 24 May 2001 14:42:27 -0400
Date: Thu, 24 May 2001 11:42:19 -0700
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: Re: how to crash 2.4.4 w/SBLive
Message-ID: <20010524114219.B21442@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <20010524063754.5547.qmail@web11607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010524063754.5547.qmail@web11607.mail.yahoo.com>; from "John Lenton" on Wednesday, 23 May 2001, at 23:37:54 (-0700)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May 24 10:58:05 prototype kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
May 24 10:58:05 prototype kernel:  printing eip:
May 24 10:58:05 prototype kernel: c01bcb40
May 24 10:58:05 prototype kernel: *pde = 00000000
May 24 10:58:05 prototype kernel: Oops: 0002
May 24 10:58:05 prototype kernel: CPU:    0
May 24 10:58:05 prototype kernel: EIP:    0010:[emu10k1_timer_uninstall+48/240]
May 24 10:58:05 prototype kernel: EFLAGS: 00210097
May 24 10:58:05 prototype kernel: eax: 00000000   ebx: ffffffff   ecx: c1c68a78   edx: 00000000
May 24 10:58:05 prototype kernel: esi: c1254070   edi: c1250000   ebp: 00200097   esp: c1c4bf34
May 24 10:58:05 prototype kernel: ds: 0018   es: 0018   ss: 0018
May 24 10:58:05 prototype kernel: Process cat (pid: 378, stackpage=c1c4b000)
May 24 10:58:05 prototype kernel: Stack: c1c68a00 c1250000 c1cb1300 c1c4a000 c1250000 c01b8b8b c1250000 c1c68a78
May 24 10:58:05 prototype kernel:        c1cb1300 c1c68a00 c1250000 c01b8b36 c1cb1300 00200246 c1c68a00 00001000
May 24 10:58:05 prototype kernel:        c01b541f c1cb1300 c1ca58c0 ffffffea 00000000 00001000 00001000 00000000
May 24 10:58:05 prototype kernel: Call Trace: [emu10k1_waveout_close+27/64] [emu10k1_waveout_open+102/160] [emu10k1_audio_write+207/464] [sys_write+150/208] [system
_call+51/56]

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
