Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUH1QeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUH1QeN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUH1QcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:32:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:49562 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267478AbUH1Q0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:26:06 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16688.45596.829372.249785@thebsh.namesys.com>
Date: Sat, 28 Aug 2004 20:26:04 +0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: flx@msu.ru, Christophe Saout <christophe@saout.de>,
       Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
In-Reply-To: <20040828161113.GA27278@delft.aura.cs.cmu.edu>
References: <412D9FE6.9050307@namesys.com>
	<20040826014542.4bfe7cc3.akpm@osdl.org>
	<1093522729.9004.40.camel@leto.cs.pocnet.net>
	<20040826124929.GA542@lst.de>
	<1093525234.9004.55.camel@leto.cs.pocnet.net>
	<20040826130718.GB820@lst.de>
	<1093526273.11694.8.camel@leto.cs.pocnet.net>
	<20040826132439.GA1188@lst.de>
	<1093527307.11694.23.camel@leto.cs.pocnet.net>
	<20040828111807.GC6746@alias>
	<20040828161113.GA27278@delft.aura.cs.cmu.edu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes writes:
 > On Sat, Aug 28, 2004 at 03:18:07PM +0400, Alexander Lyamin wrote:
 > > And I honestly dont understand whats the other Christoph's worries are about.
 > 

[...]

 > - When reiserfs3 got merged, it introduced iget3 and read_inode2 in the
 >   VFS layer. Later on when I started to use them for Coda I almost
 >   immediately found serious consistency problems, resulting in the
 >   iget4_locked implementation in the 2.5 kernels.
 >   
 >   I don't think anyone ever fixed that race in reiser3. It should hit

Err... it was fixed.


 > Jan
 > 

Nikita.
