Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJYEDP>; Fri, 25 Oct 2002 00:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbSJYEDP>; Fri, 25 Oct 2002 00:03:15 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:62213 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S261268AbSJYEDO>; Fri, 25 Oct 2002 00:03:14 -0400
Message-Id: <5.1.0.14.0.20021024210320.01db0750@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Oct 2002 21:09:20 -0700
To: hps@intermeta.de, linux-kernel@vger.kernel.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: One for the Security Guru's
In-Reply-To: <ap8f36$8ge$1@forge.intermeta.de>
References: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com>
 <Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:38 AM 10/24/02 +0000, Henning P. Schmiedehausen wrote:
>So you should've bought a more expensive firewall that offers protocol
>based forwarding instead of being a simple packet filter.
>
>packet filter != firewall. That's the main lie behind most of the
>"Linux based" firewalls.
>
>Get the real thing. Checkpoint. PIX. But that's a little
>more expensive than "xxx firewall based on Linux".

OK, I don't advertise that I'm the "know-it-all" when it comes to security, 
and in the State of Nevada (USA) I'm not allowed to advertise as a 
"security consultant" without a special license from the Private 
Investigator's License Board.

I have a firewall running on 2.4.18 (Red Hat 7.3/Valhalla with updates) 
which is (on an experimental basis) doing port-number-based forwarding to a 
Web server.  The idea is that the Web server is *not* directly on the 'Net, 
but is instead  behind a firewall that steers incoming traffic to it on two 
specific ports:  80 and 443.  (Yes, I installed the slapper on the Web 
server.)  This was done using IPTABLES.

I've also been experimenting with the traffic limiting capabilities, as one 
co-locate provider offers discounts for guaranteed lower bandwidth 
utilization, so by limiting the bandwidth using IPTABLES I should be able 
to cut my co-lo costs to 1/3 of what they would be with "unlimited" bandwidth.

I've worked with the PIX, and I don't see what I'm missing in features 
between the PIX and Linux/IPTABLES.  I'm sure there is something.  Please 
amplify on your comments.

