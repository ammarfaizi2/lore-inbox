Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbRFWKoL>; Sat, 23 Jun 2001 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265013AbRFWKoB>; Sat, 23 Jun 2001 06:44:01 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:29200 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S263851AbRFWKnx>;
	Sat, 23 Jun 2001 06:43:53 -0400
Message-ID: <3B347300.FEFF00D@bigfoot.com>
Date: Sat, 23 Jun 2001 04:44:16 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG in inode.c line 486 in 2.4.5
In-Reply-To: <3B34711A.F25ED753@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should mention, there are also NFS3 mounts on the system.. 

Dylan Griffiths wrote:
> -=-
> 
> kernel BUG at inode.c:486!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0141e43>]
> EFLAGS: 00013286
> eax: 0000001b   ebx: c726a2c0   ecx: 00000001   edx: c022a068
> esi: c022cee0   edi: d489c9c0   ebp: d501dfa4   esp: d501deec
> ds: 0018   es: 0018   ss: 0018
> Process gmc (pid: 169, stackpage=d501d000)
> Stack: c01f602c c01f608b 000001e6 c726a2c0 c0142887 c726a2c0 d4221a40
> c726a2c0
>        c015a66d c726a2c0 c01402f6 d4221a40 c726a2c0 d4221a40 00000000
> c0138d18
>        d4221a40 d501df68 c013945a d489c9c0 d501df68 00000000 cc51b000
> 00000000
> Call Trace: [<c0142887>] [<c015a66d>] [<c01402f6>] [<c0138d18>] [<c013945a>]
> [<c0139a8c>] [<c01368a6>]
>        [<c0106b9b>]
> 
> Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68
> 

--
    www.kuro5hin.org -- technology and culture, from the trenches.
