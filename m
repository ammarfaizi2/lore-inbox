Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267978AbTBXFFP>; Mon, 24 Feb 2003 00:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267989AbTBXFFP>; Mon, 24 Feb 2003 00:05:15 -0500
Received: from holomorphy.com ([66.224.33.161]:6575 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267978AbTBXFFO>;
	Mon, 24 Feb 2003 00:05:14 -0500
Date: Sun, 23 Feb 2003 21:11:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Bill Davidsen <davidsen@tmr.com>, lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224051115.GJ27135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
	Bill Davidsen <davidsen@tmr.com>, lse-tech@lists.sf.et,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030223181400.999D-100000@gatekeeper.tmr.com> <E18n9Kx-0000kA-00@w-gerrit2> <20030224040246.GA4215@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224040246.GA4215@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 07:31:26PM -0800, Gerrit Huizenga wrote:
>> But most people don't connect big machines to IDE drive subsystems.
> 
On Sun, Feb 23, 2003 at 08:02:46PM -0800, Larry McVoy wrote:
> 3ware controllers.  They look like SCSI to the host, but use cheap IDE
> drives on the back end.  Really nice cards.  bkbits.net runs on one.

A quick back of the napkin estimate guesstimates that this 3ware stuff
would max at 6 racks of disks on NUMA-Q or 3/8 of a rack per node
(ignoring cabling, which looks infeasible, but never mind that), which
is a smaller capacity than I remember FC having. NUMA-Q's a bit
optimistic for 3ware because it has buttloads of PCI slots in
comparison to more modern machines.


-- wli
