Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWCOPZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWCOPZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWCOPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:25:38 -0500
Received: from cernmx04.cern.ch ([137.138.166.167]:55219 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751273AbWCOPZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:25:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=c1qy7X58nULkqxlFNwd61+uTwaTheRBpKx1Ahs3a2RSUB7x4Egj5DOGxO99Nd6tivuNE0pD1vASQ5192+8yfZVIsoNur0QM6LIV9aNSzKwM98u0bts/jQKZwYqnQhiTL;
Keywords: CERN SpamKiller Note: -52 Charset: west-latin
X-Filter: CERNMX04 CERN MX v2.0 051012.1312 Release
Message-ID: <441831EE.90501@cern.ch>
Date: Wed, 15 Mar 2006 16:25:34 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch> <200603071332.19614.baldrick@free.fr> <4417D4ED.6010808@cern.ch> <20060315142148.GD20607@m.safari.iki.fi>
In-Reply-To: <20060315142148.GD20607@m.safari.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2006 15:25:31.0279 (UTC) FILETIME=[B249B9F0:01C64844]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:

>I didn't change xawtv configs, and
>1) with the patch system did not crash
>2) without the patch system crashed
>  
>
I've tryed to apply your patch and tested it and I've got the same 
result like without your patch - by manipulation with the XAWTV channel 
list the PC crashed and I've got in the /var/log/message this:

bttv3: OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c014,bits: HSYNC OFLOW OCERR*
OCERR @ 1c98c000,bits: HSYNC OFLOW OCERR*
timeout: drop=1 irq=5755/7129, risc=1854901c, bits: HSYNC OFLOW
reset, reinitialize
PLL: 28636363 => 35468950 . ok
bttv3: OCERR @ 1c98c01c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c014,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: OCERR @ 1c98c000,bits: VSYNC HSYNC OFLOW OCERR*
bttv3: timeout: drop=1 irq=5828/7216, risc=1c98c01c, bits: VSYNC HSYNC OFLOW
bttv3: reset, reinitialize
bttv3: PLL: 28636363 => 35468950 . ok
Unable to handle kernel paging request at virtual address 14000274
printing eip:
c013cda5
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: i915 drm ohci_hcd tuner tvaudio bttv video_buf 
i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev ehci_hcd 
uhci_hcd snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event 
snd_seq snd_seq_device snd_bt87x snd_hda_intel snd_hda_codec snd_pcm 
snd_timer snd soundcore snd_page_alloc usbcore
CPU:    0
EIP:    0060:[<c013cda5>]    Not tainted VLI
EFLAGS: 00010082   (2.6.15.1)
EIP is at free_block+0x45/0xd1
eax: 14000270   ebx: d8b34000   ecx: 203dc788   edx: 00000000
esi: df6eac00   edi: 00000000   ebp: df67ad00   esp: df64dee4
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 4, threadinfo=df64c000 task=df659a90)
Stack: df4d8a50 00000006 d8b341e4 df67c610 00000007 df67c600 00000000 
c013d3e7
df67ad00 df67c610 00000007 00000000 df67ad00 df64c000 df6eab50 df6eac00
df67ad00 c013d47c df67ad00 df67c600 00000000 00000000 00000002 df67ad4c
Call Trace:
[<c013d3e7>] drain_array_locked+0x6a/0x95
[<c013d47c>] cache_reap+0x6a/0x173
[<c0126193>] worker_thread+0x1a3/0x230
[<c013d412>] cache_reap+0x0/0x173
[<c011624d>] default_wake_function+0x0/0x12
[<c011624d>] default_wake_function+0x0/0x12
[<c0125ff0>] worker_thread+0x0/0x230
[<c012968e>] kthread+0x79/0xa3
[<c0129615>] kthread+0x0/0xa3
[<c01012c5>] kernel_thread_helper+0x5/0xb
Code: 24 8b 54 24 2c 8b 04 b8 89 44 24 08 05 00 00 00 40 c1 e8 0c 8b 74 
95 14 31 d2 c1 e0 05 03 05 30 e7 3d c0 8b 58 1c 8b 03 8b 4b 04 <89> 48 
04 89 01 c7 43 04 00 02 20 00 c7 03 00 01 10 00 8b 43 0c
<6>note: events/0[4] exited with preempt_count 1


Best Regards,
Jiri Tyr
