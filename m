Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDXKIn>; Wed, 24 Apr 2002 06:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDXKIm>; Wed, 24 Apr 2002 06:08:42 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:17939 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S311262AbSDXKIm>;
	Wed, 24 Apr 2002 06:08:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Hong-Gunn Chew" <hgchewML@optusnet.com.au>
Date: Wed, 24 Apr 2002 12:08:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: File corruption when running VMware.
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <3451C533E20@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Apr 02 at 12:54, Hong-Gunn Chew wrote:

> Further tests shows the corruption occurs only at the 3rd byte of a
> 16-byte block, and only the LSB is affected.
> Load on the machine is minimal and VMware is at the BIOS setup screen.

Never seen that, and nobody reported that. Are you sure that
vmmon/vmnet modules choosen by vmware-config.pl are correct ones?
If you exprience any problems, you should run 'vmware-config.pl --compile',
it will cause vmmon/vmnet to be build from scratch even if your
kernel looks like one for which precompiled module is available.

And next question - do you use vmmon/vmnet from VMware, or from my
site?
                                                    Petr
                                                    
