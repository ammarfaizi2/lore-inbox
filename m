Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267982AbRHATRm>; Wed, 1 Aug 2001 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbRHATRc>; Wed, 1 Aug 2001 15:17:32 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:56936 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S267974AbRHATR1>; Wed, 1 Aug 2001 15:17:27 -0400
Message-ID: <3B68557B.7816FE4B@pp.htv.fi>
Date: Wed, 01 Aug 2001 22:16:11 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Per Jessen <per.jessen@enidan.com>, linux-kernel@vger.kernel.org,
        linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch> <20010801114105.A26615@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Use the yenta module instead of the i82365 module.

Kills (deadlocks) my Toshiba Satellite when loaded as module (complains
about missing interrupts). When built into kernel it just complains but
doesn't lockup the machine.

Older kernels/pcmcia-cs i82365 was working fine. (2.2.x and early 2.4.x)

I should have stayed with RedHat 6.2, but I wanted journaling filesystem...

Maybe I'm doing something wrong but dunno what.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
