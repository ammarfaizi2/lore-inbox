Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTKYUUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTKYUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:20:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:14750 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263057AbTKYUUo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:20:44 -0500
Date: Tue, 25 Nov 2003 18:06:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-rc5
In-Reply-To: <20031125190442.GB1357@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.44.0311251802400.6489-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Nov 2003, Mike Fedyk wrote:

> On Tue, Nov 25, 2003 at 09:42:21AM -0200, Marcelo Tosatti wrote:
> > 
> > 
> > Hi, 
> > 
> > Yet another thing showed up (possible data corruption on x86-64), so here 
> > goes -rc5.
> 
> Sorry for not reading the entire 100+ message thread, but maybe someone can
> answer anyway.
> 
> Will 2.4.23 have the oom killer?

No. Andrea removed the oom killer because it had problems (deadlocks, it
can "guess" wrong in some cases).

It seems that in most cases killing the allocator (what 2.4.23 does)  
works fine.

Having it configurable might be desired. 


