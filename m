Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312456AbSCYQmx>; Mon, 25 Mar 2002 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSCYQmn>; Mon, 25 Mar 2002 11:42:43 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33802 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S312456AbSCYQmb>; Mon, 25 Mar 2002 11:42:31 -0500
Date: Mon, 25 Mar 2002 17:42:27 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dave Jones <davej@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        jonathan@woaf.net
Subject: Re: Possible problems with D-LINK DFE-550TX (stock sundance driver) under 2.4.18
Message-ID: <20020325164227.GA19001@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Dave Jones <davej@suse.de>, jonathan@woaf.net
In-Reply-To: <200203250336.08428.Dieter.Nuetzel@hamburg.de> <20020325123942.A23014@suse.de> <200203251540.37393.Dieter.Nuetzel@hamburg.de> <20020325163621.GA21260@woaf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, David Flynn wrote:

> Please, do we have to go on about the merits of Athlon XP systems in MP
> configurations ?? 1) your wrong about the bridges, it only affects iirc
> the new XP2000+ chips, 2) is it /REALLY/ the issue ?? i do not think so.
> 
> However, I am very happy to report that the system has just done it
> again.  I can't give any further details yet, although i am just going
> over to pay a visit to the box and do some more investigations.
> 
> FYI, we have two of these boxes with the same hardware / kernel
> configuration.  Two of them have now shown the same problem (eth0
> timeouts).  Including having maxcpus=1 set.
> 
> Could this perhaps be a driver issue after all ?

Of course, but you cannot tell if you run XPs in SMP configurations. If
you bad things still happen in uniprocessor mode, you know where to
look: at the driver.

-- 
Matthias Andree
