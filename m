Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbTEERGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTEERFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:05:47 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:32645 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S263754AbTEEREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:04:53 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Ezra Nugroho <ezran@goshen.edu>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Subject: Re: partitions in meta devices
Date: Mon, 5 May 2003 19:17:17 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <1052153060.29588.196.camel@ezran.goshen.edu> <3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu>
In-Reply-To: <1052153834.29676.219.camel@ezran.goshen.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305051917.17366.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 May 2003 18:57, Ezra Nugroho wrote:
> On Mon, 2003-05-05 at 11:39, Carl-Daniel Hailfinger wrote:
> > Ezra Nugroho wrote:
> > > I am curious if partitioning meta devices is allowed or not.
> > >
> > > I just created a software raid array, md0 with 240G logical size.
> > > I want to partition that into two, 100G and the rest.
> > >

Hi,

this is a question for linux-raid@vger.kernel.org. Regarding to a thread about 
a recent thread of this topic (I currently don't have the time to search it), 
partitioning of md-devices is not possible. You have to use LVM if you want 
to do something like this.

Bernd
