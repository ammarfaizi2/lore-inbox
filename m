Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275311AbTHGOeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGOeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:34:20 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:52194 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S275311AbTHGOeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:34:03 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16178.25432.716825.351618@laputa.namesys.com>
Date: Thu, 7 Aug 2003 18:34:00 +0400
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Tomas Szepe <szepe@pinerecords.com>, Oleg Drokin <green@namesys.com>,
       Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
In-Reply-To: <20030807142312.GA901@citd.de>
References: <200308070305.51868.vlad@lazarenko.net>
	<20030806230220.I7752@schatzie.adilger.int>
	<3F31DFCC.6040504@cornell.edu>
	<20030807072751.GA23912@namesys.com>
	<20030807132111.GB7094@louise.pinerecords.com>
	<20030807142312.GA901@citd.de>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer writes:
 > On Thu, Aug 07, 2003 at 03:21:11PM +0200, Tomas Szepe wrote:
 > > > [green@namesys.com]
 > > > 

[...]

 > 
 > That answers the question that poped up in my mind.
 > 
 > "How does the tool know where the blocks are, and in which order it can
 > 'move' then without corrupting the data.(*)

There is FIBMAP ioctl for this.

 > 
 > Seems it doesn't know it.
 > 
 > But it is possibel(*2) to do what the programm wants to do, you only
 > have to find out the order in which you have to copy the blocks to
 > prevent garbage. That's all the magic.
 > 

Nikita.
