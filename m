Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUIOXFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUIOXFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUIOXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:05:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:31633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267700AbUIOXCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:02:52 -0400
Date: Wed, 15 Sep 2004 16:05:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: adilger@clusterfs.com, mbligh@aracnet.com, anton@samba.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent
 patches?
Message-Id: <20040915160554.6d8350ca.akpm@osdl.org>
In-Reply-To: <4147C6D6.30508@nortelnetworks.com>
References: <41474B15.8040302@nortelnetworks.com>
	<20040915002023.GD5615@krispykreme>
	<119340000.1095209242@flay>
	<414799D1.7050609@nortelnetworks.com>
	<20040915014711.GA30607@schnapps.adilger.int>
	<4147C6D6.30508@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> wrote:
>
> Andreas Dilger wrote:
> 
> > Consider using a source-control tool next time ;-/.  
> 
> We used a source control tool.  Its just not very useful when people do a port 
> from one kernel version to the next and submit it as one giant patch against the 
> new kernel rather than new versions of the original individual patches.
> 
> I'm the one planning how to avoid this problem in our next development cycle.
> 

What others said.

Once you apply those patches to your baseline tree you're dead.  If your
primary revision-controlled objects are baseline+patch1+patch2+...+patchN
then life is much simpler when some smarty decides to uprev baseline.
