Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQKILJ6>; Thu, 9 Nov 2000 06:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQKILJk>; Thu, 9 Nov 2000 06:09:40 -0500
Received: from fep3-orange.clear.net.nz ([203.97.32.3]:2044 "EHLO
	fep3-orange.clear.net.nz") by vger.kernel.org with ESMTP
	id <S130067AbQKILJ2>; Thu, 9 Nov 2000 06:09:28 -0500
Date: Fri, 10 Nov 2000 00:09:11 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Michele Iacobellis <miacobellis@linuximpresa.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No tcp connection establishment with 2.4
Message-ID: <20001110000911.A1235@metastasis.f00f.org>
In-Reply-To: <20001109110354.872F0186@linuximpresa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001109110354.872F0186@linuximpresa.it>; from miacobellis@linuximpresa.it on Thu, Nov 09, 2000 at 12:08:32PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 12:08:32PM +0100, Michele Iacobellis wrote:

    [Summary]
    No tcp connection establishment with 2.4
    
    [Description]
    I know these sites use some versions of linux:
    
    www.libero.it
    www.iol.it
    www.arianna.it
    
    and some other outside Italy.
    
My guess was TCP_ECN, but when I try even with this enabled it works.
If it fails for you still try:

	echo 0 > /proc/sys/net/ipv4/tcp_ecn

and see if that fixes it.


  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
