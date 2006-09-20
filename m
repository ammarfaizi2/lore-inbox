Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWITW7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWITW7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWITW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:59:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26001 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932452AbWITW7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:59:13 -0400
Date: Wed, 20 Sep 2006 15:59:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: npiggin@suse.de, rohitseth@google.com, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <20060920152753.6f3a3221.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0609201558170.1026@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <20060920164404.GA22913@wotan.suse.de> <Pine.LNX.4.64.0609200944420.30793@schroedinger.engr.sgi.com>
 <20060920170735.GB22913@wotan.suse.de> <Pine.LNX.4.64.0609201008160.30793@schroedinger.engr.sgi.com>
 <20060920152753.6f3a3221.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Paul Jackson wrote:

> > Hmmm... That gets into issues of knowing how many pages are in use by an 
> > application and that is fundamentally difficult to do due to pages being 
> > shared between processes.
> 
> Fundamentally difficult or not, it seems to be required for what Nick
> describes, and for sure cpusets doesn't do it (track memory usage per
> container.)

We have the memory usage on a node. So in that sense we track memory 
usage. We also have VM counters for that node or nodes that describe 
resource usage.
