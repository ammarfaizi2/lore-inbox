Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423029AbWAMW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWAMW0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWAMW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:26:50 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:61313 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1423029AbWAMW0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:26:49 -0500
Date: Fri, 13 Jan 2006 17:26:48 -0500
To: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>
Cc: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net
Subject: Re: no carrier when using forcedeth on MSI K8N Neo4-F
Message-ID: <20060113222647.GB18972@csclub.uwaterloo.ca>
References: <43C7F35A.9010703@summitinstruments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C7F35A.9010703@summitinstruments.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 01:37:14PM -0500, Arne R. van der Heyde wrote:
> I am trying to connect two identical MSI K8N Neo4-F servers with NVIDIA 
> nForce4 gigabit Lan ports. When the two ports are connected together via 
> a crossover cable, neither computer is able to detect a carrier on the 
> Lan ports and are not able to communicate. When either of the nForce4 
> gigabit port is connected to a Lan port on another computer with a 
> different Lan hardware or to a port on a switch the forcedeth drivers 
> detect a carrier and are able to communicate.

Gigabit does NOT use cross over cables.  You connect gig ports with a
normal ethernet cable at all times unless you are connecting to a 10 or
100mbit port at the other end.  When running at gigabit speed, there are
4 pairs of wire in use with full duplex on all 4 pairs.  10 and 100mbit
have a single pair for data each way, and hence need the cross over when
not connecting to a switch/router.

> It appears that the nForce4 Gigabit ports are not generating a carrier. 
> Does the nForce4 not provide standard ethernet ports? If they are 
> standard ethernet ports, how do I tell forcedeth to generate a carrier? 
> Also how do I get forcedeth to run at a Gigabit?

Hopefully using the right cable type will solve the problem.

Len Sorensen
