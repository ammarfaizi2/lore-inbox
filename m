Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUGUUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUGUUqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUGUUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:46:19 -0400
Received: from web50906.mail.yahoo.com ([206.190.38.126]:39072 "HELO
	web50906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266732AbUGUUqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:46:07 -0400
Message-ID: <20040721204602.35891.qmail@web50906.mail.yahoo.com>
Date: Wed, 21 Jul 2004 13:46:02 -0700 (PDT)
From: sankarshana rao <san_wipro@yahoo.com>
Subject: Re: Inode question
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1090441528.17486.25.camel@shaggy.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the reply...
When I try to call lookup() from my kernel module, it
gives undefined symbol error during INSMOD..
any clues???

--- Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Wed, 2004-07-21 at 13:39, sankarshana rao wrote:
> > Hi,
> > I want to call namei() function in order to derive
> an
> > inode from a path name. Can I do this inside a
> kernel
> > module???
> 
> >From a kernel module, you should probably call
> path_lookup().
> 
> Shaggy
> -- 
> David Kleikamp
> IBM Linux Technology Center
> 
> 



	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/
