Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267283AbTAGEMV>; Mon, 6 Jan 2003 23:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAGEMU>; Mon, 6 Jan 2003 23:12:20 -0500
Received: from waste.org ([209.173.204.2]:11162 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267283AbTAGEMU>;
	Mon, 6 Jan 2003 23:12:20 -0500
Date: Mon, 6 Jan 2003 22:20:46 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107042045.GA10045@waste.org>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17360000.1041899978@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
> Hmm.  The problem here is that there is a nontrivial probability that a 
> packet can pass both ethernet and TCP checksums and still not be right, 
> given the gigantic volumes of data that iSCSI is intended to be used with. 
> Back up a 100 terabyte array and it's more than 1%, back of the envelope.

What was the underlying error rate and distribution you assumed? I
figure if it were high enough to get to your 1%, you'd have such high
retry rates (and resulting throughput loss) that the operator would
notice his LAN was broken weeks before said transfer completed.
 
-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
