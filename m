Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSIWT6z>; Mon, 23 Sep 2002 15:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSIWT6z>; Mon, 23 Sep 2002 15:58:55 -0400
Received: from fmr05.intel.com ([134.134.136.6]:23031 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261282AbSIWT6x>; Mon, 23 Sep 2002 15:58:53 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C446047589DF@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Todor Todorov'" <ttodorov@web.de>, linux-kernel@vger.kernel.org
Subject: RE: eepro100/e100 drivers fragment heavily
Date: Mon, 23 Sep 2002 13:03:58 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todor Todorov wrote:

> The computer is a 
> Dell Inspiron 8000 laptop with an internal Actiontec 
> modem/nic combo pci card based on the Intel Pro chip, running 
> Debian. I observed this behaviour with the eepro100 drivers 
> in 2.4.19, 2.4.20-pre6 and 2.4.20-pre7 and e100 drivers in 
> 2.4.20-pre6 and -pre7. Pulling data from the network is fine 
> and fast though, only sending is a problem. The only hint I 
> have of what migh be causing the problem is something I read 
> in the specs of my NWAY SOHO switch - it would allow 
> full-duplex 100 MBit/sec only based on auto negotiation, if a 
> nic is in forced mode (say 100 MBit full-duplex), the swith 
> will allow only 100 MBit half-duplex. I tried other high 
> quality switches too, but the result was the same. 

Please confirm that the switch and nic are both set to auto-neg, or both the
switch and the nic forced to the same settings (i.e. 100/half).  We need to
make sure both ends of the wire match.

-scott
