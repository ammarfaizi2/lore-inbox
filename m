Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946604AbWKAGBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946604AbWKAGBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946602AbWKAGBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:01:13 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:17832 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946600AbWKAGBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:01:11 -0500
Date: Tue, 31 Oct 2006 22:00:53 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Pavel Emelianov <xemul@openvz.org>
cc: balbir@in.ibm.com, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
In-Reply-To: <4547305A.9070903@openvz.org>
Message-ID: <Pine.LNX.4.64N.0610312158240.18766@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
 <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org>
 <45472B68.1050506@in.ibm.com> <4547305A.9070903@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Pavel Emelianov wrote:

> Paul Menage won't agree. He believes that interface must come first.
> I also remind you that the latest beancounter patch provides all the
> stuff we're discussing. It may move tasks, limit all three resources
> discussed, reclaim memory and so on. And configfs interface could be
> attached easily.
> 

There's really two different interfaces: those to the controller and those 
to the container.  While the configfs (or simpler fs implementation solely 
for our purposes) is the most logical because of its inherent hierarchial 
nature, it seems like the only criticism on that has come from UBC.  From 
my understanding of beancounter, it could be implemented on top of any 
such container abstraction anyway.

		David
