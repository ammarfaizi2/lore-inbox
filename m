Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRIIP2Q>; Sun, 9 Sep 2001 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271997AbRIIP2H>; Sun, 9 Sep 2001 11:28:07 -0400
Received: from samar.sasken.com ([164.164.56.2]:3571 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S271995AbRIIP1y>;
	Sun, 9 Sep 2001 11:27:54 -0400
From: "Shiva Raman Pandey" <shiva@sasken.com>
Subject: Query about Tun/Tap Modules
Date: Sun, 9 Sep 2001 20:58:56 +0530
Message-ID: <9ng1q4$or1$1@ncc-z.sasken.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.00.2919.6700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
I want to trap the ethernet packets from ethernet driver and then send it
through a Bluetooth stack whose output will be in turn send through IP then
TCP layers and vice-versa.(As a result inserting bluetooth stack between
ethernet and IP layers) It is clear from the picture below.


|--------------------------------------------|
|             TCP                                              |
|--------------------------------------------|
                            |
               bi directional Interface
                            |
|--------------------------------------------|
|             IP                                                 |
|--------------------------------------------|
                            |
               bi directional Interface

|---------------------------------------------------------

|                                                |

|   Bluetooth                              |

|   Stack                                    |

|                                                |

|                                                |

|                                                |

|                                                |

|---------------------------------------------------------
               bi directional Interface
                            |
|--------------------------------------------|
|             Ethernet                                         |
|--------------------------------------------|


For these message tapping I got this module called Tun/Tap at
http://vtun.sourceforge.net/tun
Some info about this is available at
http://www.linuxhq.com/kernel/v2.4/doc/networking/tuntap.txt.html   also.

I compiled this module, made install, and insmod also.
Till here no problem.
My queries are -

Q1 : Now I am not able to understand how to use this module for my above
stated purpose.
     If anybody has used this utility(Tun/tap) before , please let me know
how to get these ethernet packet going towards IP layer and IP packets going
towards ethernet driver.

Q2. What can be other ways, not very complicated  to solve my purpose
instead of using Tun/Tap.

Q3. All the debug message are going to /var/log/messages, even if I send
with the loglevel 1. How to get them on screen? How can I see the default
console loglevel?

Hope to get an early reply.

Thanks  a lot.
Shiva Raman Pandey
Research Associate-Computer Science R&D
Sasken Communication Technologies Limited.
Bangalore-India






