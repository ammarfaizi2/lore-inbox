Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTAUFN1>; Tue, 21 Jan 2003 00:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAUFN1>; Tue, 21 Jan 2003 00:13:27 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:46214
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S263342AbTAUFN1>; Tue, 21 Jan 2003 00:13:27 -0500
Message-ID: <3E2CD91B.2080305@tupshin.com>
Date: Mon, 20 Jan 2003 21:22:35 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: "David D. Hagood" <wowbagger@sktc.net>
CC: AnonimoVeneziano <voloterreno@tin.it>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it> <3E2C9623.60709@sktc.net>
In-Reply-To: <3E2C9623.60709@sktc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:

> It is most likely a hardware problem.
>
I wouldn't necessarily assume a hardware problem (unless we also include 
chipset oddities). I get *exactly* one message stating exactly this per 
boot, and it always come a few seconds after loading the parport and 
parport_pc modules.

one example:
Jan 20 09:20:21 testing kernel: parport0: PC-style at 0x378 [PCSPP,EPP]
Jan 20 09:20:21 testing kernel: parport_pc: Via 686A parallel port: io=0x378
<snip>
Jan 20 09:20:07 testing kernel: spurious 8259A interrupt: IRQ7.

-Tupshin


