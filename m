Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUIOF1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUIOF1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 01:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIOF1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 01:27:47 -0400
Received: from jade.spiritone.com ([216.99.193.136]:47328 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267588AbUIOF1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 01:27:44 -0400
Date: Tue, 14 Sep 2004 22:27:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       Andreas Dilger <adilger@clusterfs.com>
cc: Anton Blanchard <anton@samba.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <773640000.1095226032@[10.10.2.4]>
In-Reply-To: <4147C6D6.30508@nortelnetworks.com>
References: <41474B15.8040302@nortelnetworks.com> <20040915002023.GD5615@krispykreme> <119340000.1095209242@flay> <414799D1.7050609@nortelnetworks.com> <20040915014711.GA30607@schnapps.adilger.int> <4147C6D6.30508@nortelnetworks.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Consider using a source-control tool next time ;-/.  
> 
> We used a source control tool.  Its just not very useful when people do a port from one kernel version to the next and submit it as one giant patch against the new kernel rather than new versions of the original individual patches.
> 
> I'm the one planning how to avoid this problem in our next development cycle.

Having maintained my own tree for a while, what I'd suggest is to keep a
sequence of flat patches, then apply and port then ONE AT A TIME to each
new kernel version. Once you get a system down, it really doesn't take
long to do. 

Personally I find source control tools utterly useless for exactly this 
reason. Akpm uses his own set of tools which someone packaged up as
"quilt" I think. I have a similar set that works by patch number, his
are controlled by a series file. Suggest you look at his tools - if he
can manage a release every few days with several hundred patches in, they
must work pretty well ;-)

M.

