Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbQLHJS2>; Fri, 8 Dec 2000 04:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbQLHJSS>; Fri, 8 Dec 2000 04:18:18 -0500
Received: from d1-u6.test.clear.net.nz ([203.97.54.198]:8196 "HELO
	tapu.f00f.org") by vger.kernel.org with SMTP id <S129590AbQLHJSG>;
	Fri, 8 Dec 2000 04:18:06 -0500
Date: Fri, 8 Dec 2000 21:47:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0test10: 3c59x: Transmit timed out
Message-ID: <20001208214736.A429@tapu>
In-Reply-To: <20001208064729.0857242544F@grumbeer.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001208064729.0857242544F@grumbeer.hjb.de>; from hjb@pro-linux.de on Fri, Dec 08, 2000 at 07:47:29AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 07:47:29AM +0100, Hans-Joachim Baader wrote:

    
    I got the following timeout on an SMP system:
    
    3c59x.c:LK1.1.9  2 Sep 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.38 $
    See Documentation/networking/vortex.txt
    eth0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xa800,  00:60:97:b0:c2:25, IRQ 10
      8K word-wide RAM 3:5 Rx:Tx split, autoselect/10base2 interface.
        Enabling bus-master transmits and whole-frame receives.
    
    
    NETDEV WATCHDOG: eth0: transmit timed out
    eth0: transmit timed out, tx_status 00 status e000.
    Flags; bus-master 1, full 1; dirty 8031(15) current 8047(15).
    Transmit list 05d802f0 vs. c5d802f0.
    0: @c5d80200  length 8000002a status 0000002a
    1: @c5d80210  length 8000002a status 0000002a
    2: @c5d80220  length 8000002a status 0000002a
    3: @c5d80230  length 8000002a status 0000002a
    4: @c5d80240  length 8000002a status 0000002a
    5: @c5d80250  length 8000002a status 0000002a
    6: @c5d80260  length 8000002a status 0000002a
    7: @c5d80270  length 8000002a status 0000002a
    8: @c5d80280  length 8000002a status 0000002a
    9: @c5d80290  length 8000002a status 0000002a
    10: @c5d802a0  length 8000002a status 0000002a
    11: @c5d802b0  length 8000002a status 0000002a
    12: @c5d802c0  length 8000002a status 0000002a
    13: @c5d802d0  length 8000002a status 8000002a
    14: @c5d802e0  length 8000002a status 8000002a
    15: @c5d802f0  length 8000002a status 0000002a

Check the cards duplex is the same as what it is connected to. I see
these errors when they are mismatched... 




 --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
