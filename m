Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUKKPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUKKPBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUKKPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:01:37 -0500
Received: from ppp-217-133-78-146.cust-adsl.tiscali.it ([217.133.78.146]:28202
	"EHLO gw.planetek.it") by vger.kernel.org with ESMTP
	id S262248AbUKKPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:00:26 -0500
From: "Domenico Gargano" <d.gargano@planetek.it>
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Nov 2004 16:00:20 +0100
MIME-Version: 1.0
Subject: weird blocked sync packets on win machines
Message-ID: <41938C94.24206.17593FE@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
strange things happen on my linuxbox, I've got a firewall box running
fedora 2 with 5 net 
adapters. All my private machines (192.168.30.) connect to internet and to
my DMZ 
through the linuxbox.
During the day usually happens that my firewall stop forwarding SYN
packets, allowing 
instead all other packets (ex. ACK) and all other protocols. This means
that I cannot 
establish only new connections (prevoiously opened ones just work fine).
All my eth stop forwarding for 15 minutes, all the new traffic is totally
blocked (from/to 
LAN, DMZ, INTERNET).
The really weird thing is that this happen only on windows machines, and
during this 
block-time, if I close all IE windows and then I re-open IE, all
connections start again to 
work (without waiting 15 minutes), this trick works only if my IE is using
squiq proxy 
running on a server located in DMZ.
I've upgraded the kernel from 2.4.22 to all new releases since 2.6.8 but
nothing has 
changed, I've changed all net adapters and fine-tuning kernel parameters
(like disable 
syn-protect or increase nr. connections and decrease timeout values).
All tests are done with tcpdump.
Can someone please suggest me some way to find a solution? I'm not only
looking for 
the right solution, but also some method to study this weird problem.
Thanks

pls put me in CC when replying.

-- 
~~~  Domenico Gargano  [Senior Network Manager]  ~~~
Planetek Italia s.r.l.                        :tel:+39 080 5343750
Via Massaua, 12 - I-70123 BARI     :fax:+39 080 5340280
~~ email:  d.gargano@planetek.it ~~~ www.planetek.it ~~

