Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318939AbSICVMr>; Tue, 3 Sep 2002 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318941AbSICVMr>; Tue, 3 Sep 2002 17:12:47 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:14845 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318939AbSICVMq>; Tue, 3 Sep 2002 17:12:46 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 3 Sep 2002 15:15:01 -0600
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Lars Marowsky-Bree <lmb@suse.de>, root@chaos.analogic.com,
       Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020903211501.GT32468@clusterfs.com>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	Lars Marowsky-Bree <lmb@suse.de>, root@chaos.analogic.com,
	Rik van Riel <riel@conectiva.com.br>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20020903185344.GA7836@marowsky-bree.de> <200209032107.g83L71h10758@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209032107.g83L71h10758@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03, 2002  23:07 +0200, Peter T. Breuer wrote:
> You don't really want the whole rationale. It concerns certain 
> european (nay, world ..) scientific projects and the calculations of the
> technologists about the progress in hardware over the next few years.
> We/they foresee that we will have to move to multiple relatively small
> distributed disks per node in order to keep the bandwidth per unit of
> storage at the levels that they will have to be at to keep the farms
> fed.  We are talking petabytes of data storage in thousands of nodes
> moving over gigabit networks.
> 
> The "big view" calculations indicate that we must have distributed
> shared writable data.
> 
> These calculations affect us all. They show us what way computing
> will evolve under the price and technology pressures. The calculations
> are only looking to 2006, but that's what they show. For example
> if we think about a 5PB system made of 5000 disks of 1TB each in a GE
> net, we calculate the aggregate bandwidth available in the topology as
> 50GB/s, which is less than we need in order to keep the nodes fed
> at the rates they could be fed at (yes, a few % loss translates into
> time and money).  To increase available bandwidth we must have more
> channels to the disks, and more disks, ... well, you catch my drift.
> 
> So, start thinking about general mechanisms to do distributed storage.
> Not particular FS solutions.

Please see lustre.org.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

