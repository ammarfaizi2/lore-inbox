Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135504AbREEWMO>; Sat, 5 May 2001 18:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135506AbREEWMF>; Sat, 5 May 2001 18:12:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8087 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135504AbREEWLu>;
	Sat, 5 May 2001 18:11:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15092.31381.395563.889405@pizda.ninka.net>
Date: Sat, 5 May 2001 15:11:33 -0700 (PDT)
To: "Svenning Soerensen" <svenning@post5.tele.dk>
Cc: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: RE: Problem with PMTU discovery on ICMP packets
In-Reply-To: <015401c0d56e$ee293250$1400a8c0@sss.intermate.com>
In-Reply-To: <15091.59308.315685.312632@pizda.ninka.net>
	<015401c0d56e$ee293250$1400a8c0@sss.intermate.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Svenning Soerensen writes:
 > Yes, I see your point. I guess I made an incorrect assumption about it
 > being changed between reboots. It could be related to routing or something
 > instead. I'll have to dig a bit further to find a pattern. 
 > 
 > However, even if I *do* find the pattern, I still think it is reasonable
 > to turn off PMTU discovery for ICMP explicitly, instead of based on the
 > setting of ipv4_config:

I totally agree with you.

But I first want to know the real story behind this reboot anomaly.
Then we will fix any new bug we discover, and apply the icmp patch as
well.

Later,
David S. Miller
davem@redhat.com
