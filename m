Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131149AbQK3UGM>; Thu, 30 Nov 2000 15:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131143AbQK3UGA>; Thu, 30 Nov 2000 15:06:00 -0500
Received: from main.cyclades.com ([209.128.87.2]:26642 "EHLO cyclades.com")
        by vger.kernel.org with ESMTP id <S131145AbQK3Tqz>;
        Thu, 30 Nov 2000 14:46:55 -0500
Date: Thu, 30 Nov 2000 11:16:52 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <Pine.LNX.4.10.10011301103320.4692-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

For synchronous network interfaces, besides configuring network parameters
such as IP address, netmask, MTU, etc., the system should also configure
parameters specific to these sync i/f's, such as media (e.g V.35, X.21,
T1, E1), clock (internal or external, and value if int.), protocol (e.g
PPP, HDLC, Frame Relay), etc.

What I noticed was that each synchronous board in Linux provides a
different way of doing this, and it would be good for users to have a
single, standard interface (such as ifconfig) to do this type of
configuration. Maybe even patch ifconfig itself, I don't know ...

Questions:
- Is there any existing _standard_ interface to do that??
- If not, is there any existing _standard_ infrastructure (e.g. ioctls and
  structures) so that I can write an application to do that over this 
  standard structure?
- If not, where would be the right place in the kernel to change in order 
  to implement such infrastructure?

I'm interested in implementing this, but I don't want to reinvent the
wheel (if such wheel exists ...).

Thanks in advance for your comments.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
