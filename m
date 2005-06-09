Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVFIBvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVFIBvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVFIBvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:51:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61568 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262220AbVFIBvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:51:39 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050608135138.GX23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <200506051015.33723.kernel-stuff@comcast.net>
	 <20050606092925.GA23831@wotan.suse.de>
	 <200506060746.23047.kernel-stuff@comcast.net>
	 <20050608135138.GX23831@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 21:47:15 -0400
Message-Id: <1118281635.6247.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 15:51 +0200, Andi Kleen wrote:
> On Mon, Jun 06, 2005 at 07:46:22AM -0400, Parag Warudkar wrote:
> > On Monday 06 June 2005 05:29, Andi Kleen wrote:
> > > And does it work with nopmtimer ?
> > >
> > > -Andi
> > 
> > Thanks for trimming the CC list. 
> > 
> > No it doesn't work with nopmtimer - music still plays fast. I have to go back 
> > to 2.6.11 to get it to play at right speed. 
> 
> Then it is something else, not the pmtimer.
> 
> I dont know what it could be. Do a binary search? 

XMMS has a long history of buggy ALSA support, which has improved
lately.  Make sure you're using the latest version.

Also try 2.6.11 with ALSA 1.0.9, maybe it's an interaction between ALSA
and the new gettimeofday patches.

Lee

