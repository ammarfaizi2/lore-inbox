Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbSJPMpU>; Wed, 16 Oct 2002 08:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPMpU>; Wed, 16 Oct 2002 08:45:20 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:21777 "EHLO
	doughboy.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262461AbSJPMpT>; Wed, 16 Oct 2002 08:45:19 -0400
Message-ID: <3DAD6062.30906@snapgear.com>
Date: Wed, 16 Oct 2002 22:49:38 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
References: <3DAC337D.7010804@snapgear.com> <buoit03lz1n.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miles,

Miles Bader wrote:

> Here's a v850 update for 2.5.42uc1.


I have rolled this into, linux-2.5.43uc0.
I have also removed the gdb patches under arch/v850.


> I addressed two of Christoph Hellwig's concerns, (1) vmlinux.lds.S
> [barf] and (2) the asm-constant generation mechanism.
> 
> He also complained about using the MD driver &c instead of initrd, but
> I'm not sure what do about that -- it'd be nice to use a `standard'
> solution, but when I originally looked at the initrd stuff, it seemed
> very convoluted and confusing; since earlier lkml discussion had pointed
> to using MD as the nearest thing to the old blkmem device, that seemed
> like the way to go.


I very much like using a specific MTD map driver. I haven't carried
my initrd patches through to the 2.5 code yet. But it was pretty
simple to do for 2.4...

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

