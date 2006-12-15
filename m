Return-Path: <linux-kernel-owner+w=401wt.eu-S1030392AbWLOXPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWLOXPj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWLOXPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:15:39 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:6126 "EHLO
	gans.physik3.uni-rostock.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030392AbWLOXPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:15:38 -0500
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 18:15:38 EST
Date: Fri, 15 Dec 2006 23:54:37 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006, Robert P. J. Day wrote:
> On Fri, 15 Dec 2006, Jan Engelhardt wrote:
> > Even  sizeof a / sizeof *a
> >
> > may happen.
> 
> yes, sadly, there are a number of those as well.  back to the drawing
> board.

It might be interesting to grep for anything that divides two sizeofs and 
eyeball the result for possible mistakes. This would provide some real 
benefit beyond the cosmetical changes.

Tim
