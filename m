Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314623AbSD0WTQ>; Sat, 27 Apr 2002 18:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314624AbSD0WTP>; Sat, 27 Apr 2002 18:19:15 -0400
Received: from family.zawodny.com ([63.174.200.26]:26852 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S314623AbSD0WTP>; Sat, 27 Apr 2002 18:19:15 -0400
Date: Sat, 27 Apr 2002 15:19:05 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Lars Weitze <cd@kalkatraz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 100 Mbit on slow machine
Message-ID: <20020427221905.GA10112@thinkpad0.zawodny.com>
In-Reply-To: <20020427195609.0a397df9.cd@kalkatraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uptime: 15:18:13 up 19 days, 22:20,  6 users,  load average: 0.01, 0.01, 0.00
X-Os-Info: Linux thinkpad0 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 07:56:09PM +0200, Lars Weitze wrote:
> Hi,
> 
> I am using a P200 MMX as an Fileserver. After i upgraded it to an 100
> Mbit/s NIC (tulip chip and 3Com "Vortex" tried) i am getting the follwing
> behaviour: The network stack seems to "block" when sending files to the
> machine with full 100 Mbit/s. There are -no- kernel messages. Doing a ping
> an the machine gives all ping packets back in "one bunch". Even after
> stopping accesing the machine at full speed (stopping the transfer) i am
> just getting this "packaged" ping reply (9000 ms and more).

Have you verified that the duplex settings are correct?  I've had
problems on more than one occasion with mismatched duplex on 100Mbit
cards (and switches).

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/
