Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTLNXzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLNXzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:55:49 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:15309 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S262789AbTLNXzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:55:48 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Sis900 ethernet dropping 70% packets
Date: Sun, 14 Dec 2003 23:55:45 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312142355.45631.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to install a little Via C3 machine with on-board Sis900 ethernet. 
As usual, I booted my LNX-BBC rescue disk, configured eth0 and tried to scp 
my distro over, but failed miserably.

Pinging other hosts on the net sees 70-80% packets getting lost.

LNX-BBC rescue cd uses a 2.4.19 kernel

So then I tried a Trinity rescue disk, using a 2.4.21 kernel. Same thing.

Anybody got experience of this? Googling gives wads of people with similar 
sounding problems, mostly interrupt related, sometimes Vlan related (It's 
plugged into a Cisco catalyst but I tried a x-over cable to my laptop with 
the same result, so I don't think thats relevant), but don't see any 
solutions.

Is this a known-bad interface? The drivers sources don't seem to have been 
touched for a long time which makes me think its unlikely that a newer kernel 
would help, but who knows...

Any suggestions apprieciated

Andrew Walrond

