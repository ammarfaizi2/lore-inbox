Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTE2XEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTE2XEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:04:23 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:28147 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263146AbTE2XET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:04:19 -0400
Date: Thu, 29 May 2003 17:17:03 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Mark Peloquin <peloquin@austin.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Nightly regression runs against current bk tree
Message-ID: <20030529171703.U29153@schatzie.adilger.int>
Mail-Followup-To: Mark Peloquin <peloquin@austin.ibm.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel> <p73smqx791m.fsf@oldwotan.suse.de> <3ED68E3E.1060403@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ED68E3E.1060403@austin.ibm.com>; from peloquin@austin.ibm.com on Thu, May 29, 2003 at 05:48:30PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2003  17:48 -0500, Mark Peloquin wrote:
> Your correct. We're just getting started with this effort and we used 
> this mix to get things going. Once ppl are happy with the presentation 
> of data, we planned to add more tests to provide a more balanced mix. 
> But since you asked, we have added lmbench to our -bk3 regression run. :)

Mark, it would be nice to get a graph of the combined results for each
test.  Something like:

                 tiobench sequential write rate
  |                                  +++++++++++++++++      + = -mm-ext3
M |        ++++++++++++++++++++++++++*****************      * = linus-ext3
B | +++++++*****************   ######                       # = -ac-ext3
/ |                                                         . = -mm-XFS
s |                                                         = = -ac-XFS
  |                         *********                       etc
  |
  +----------------------------------------------------
			date

This allows at-a-glance trends for each group of tests and (as in the
example above you could see easily when a performance bug was added
and fixed in -ac before in the linus kernel, for example).  Probably
having all of the comparable results on the same page, or even in the
same graph results is a win.

Bonus points if you can click on a spot in the graph and get the results
page for that date/test ;-).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

