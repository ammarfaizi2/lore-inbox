Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSIFDeA>; Thu, 5 Sep 2002 23:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSIFDeA>; Thu, 5 Sep 2002 23:34:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21915 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318310AbSIFDd7>;
	Thu, 5 Sep 2002 23:33:59 -0400
Message-ID: <1031283490.3d7823228d9ed@imap.linux.ibm.com>
Date: Thu,  5 Sep 2002 20:38:10 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Troy Wilson <tcw@tempest.prismnet.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <Pine.GSO.4.30.0209052129580.21731-100000@shell.cyberus.ca>
In-Reply-To: <Pine.GSO.4.30.0209052129580.21731-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.33.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jamal <hadi@cyberus.ca>:

> I am not sure; if he gets a busy system in a congested network, i
> can see the offloading savings i.e i am not sure if the amortization
> of the calls away from the CPU is sufficient enough savings if it
> doesnt involve a lot of retransmits. I am also wondering how smart
> this NIC in doing the retransmits; example i have doubts if this
> idea is briliant to begin with; does it handle SACKs for example?

do you mean sack data being sent as a tcp option? 
dont know, lots of other questions arise (like timestamp
on all the segments would be the same?). 

 
> Troy, i am not interested in the nestat -s data rather the TCP
> stats this NIC  has exposed. Unless those somehow show up magically
> in netstat.

most recent (dont know how far back) versions of netstat
display /proc/net/snmp and /proc/net/netstat (with the 
Linux TCP MIB), so netstat -s should show you most of 
whats interesting. Or were you referring to something else?

ifconfig -a and netstat -rn would also be nice to have..

thanks,
Nivedita




