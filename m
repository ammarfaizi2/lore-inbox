Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319452AbSILGa2>; Thu, 12 Sep 2002 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319453AbSILGa1>; Thu, 12 Sep 2002 02:30:27 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:1955 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S319452AbSILGa1> convert rfc822-to-8bit; Thu, 12 Sep 2002 02:30:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
Date: Thu, 12 Sep 2002 08:36:52 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20020911223252.GA12517@erik.ca> <20020911.153132.63843642.davem@redhat.com>
In-Reply-To: <20020911.153132.63843642.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209120836.52062.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, list,

Ebtables is a project similar to iptables, but working on the bridge netfilter 
hooks. It allows for a basic transparent firewall, making a brouter and doing 
MAC source address and destination address manipulation. The firewall part 
has currently modules for basic IP filtering, 802.1q filtering, ARP 
filtering, logging and a mark match/target.
Ebtables has been under development for over 1.5 year and has more than 100 
users, I think.

The patch is 3662 lines long, so I won't list it in this mail. It is available 
at:
http://users.pandora.be/bart.de.schuymer/ebtables/v2.0/ebtables-v2.0_vs_2.5.34.diff
or, gzipped:
http://users.pandora.be/bart.de.schuymer/ebtables/v2.0/ebtables-v2.0_vs_2.5.34.diff.gz

It is vs 2.5.34, I can make a patch vs 2.4.x when the time is right.
Comments/questions are appreciated.

For more information, see
http://users.pandora.be/bart.de.schuymer/ebtables/
There is an ebtables hacking howto, some basic examples and some real life 
examples from users. And ofcourse the userspace program.

-- 
cheers,
Bart

