Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264904AbSJ3VXM>; Wed, 30 Oct 2002 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbSJ3VXM>; Wed, 30 Oct 2002 16:23:12 -0500
Received: from [24.82.92.252] ([24.82.92.252]:44060 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264904AbSJ3VXL>; Wed, 30 Oct 2002 16:23:11 -0500
Message-ID: <3DC05044.5020301@silksystems.com>
Date: Wed, 30 Oct 2002 13:33:56 -0800
From: Richard Moss <rick@silksystems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerdfelt@sventech.com, linux-kernel@vger.kernel.org
Subject: cpia and smp dead locks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sorry if this goes to the wrong person but I'm
tring to submit a bug report to the cpia maintainer

1. cpia hangs smp kernel (deadlock)
2. if you compile in the cpia to the SMP kernel as either
    a module or into the bootable image, when the
    kernel or module load the cpia you get a deadlock
    no ctrl+alt+del no atl+f2 deadeadead :) sorry but
    no OOPS just frozen, this does not happen with
    non-SMP (tested with 2.4.18-17 and 2.4.19)
3. keyword. cpia webcam v4l ?
4. Linux version 2.4.19smp (gcc version 2.96 20000731 (Red Hat Linux 7.3 
2.96-112)
5. not much else to put into here other than it's been working fine 
untill 2.4.18-17smp
    redhat kernel
6. Dell poweredge dual PII 233 with 128 megs ram , parallel port 
creative webcam ver II
7. I did try the new 1.2.2 from souorce forge & compiled as but a 
bootable image &
    module with the same results

Love to tell you more but deadloacks gives no errors or logs, let me 
know if I can help

Thanks Rick Moss
rick@silksystems.com
rick@tdm.silk.ca

