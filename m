Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFCSLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFCSLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFCSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:11:08 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:59020 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261467AbVFCSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:10:54 -0400
Date: Fri, 3 Jun 2005 11:10:49 -0700 (PDT)
From: dwhite <dwhite@speakeasy.net>
X-X-Sender: dave@willie
To: linux-kernel@vger.kernel.org
Subject: icmp redirects on one-armed linux routers
Message-ID: <Pine.LNX.4.61.0506031013001.19971@willie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just wondering, is there any reason why the patch mentioned in the 
following post has not been implemented (as of kernel 2.6.11.11 it is 
not)? Is it a matter of testing? Is there a better alternative to solve 
the problem described in the thread?

http://oss.sgi.com/projects/netdev/archive/2004-07/msg00512.html

The current behavior (unchanged from that described in the post above) can 
be problematic, for example when I want to do stateful firewalling on my 
linux router.  I've been applying the patch therein to recent kernels and 
it seems to be doing the right thing (sends redirects only when the 
redirect target is on the same subnet as the sending host).

Any thoughts?
TIA

-dave (IANAP)
ps. please cc me directly in your response :)
