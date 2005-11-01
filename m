Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVKARow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKARow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVKARow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:44:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56767 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751053AbVKARov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:44:51 -0500
Date: Tue, 1 Nov 2005 09:44:26 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rob Landley <rob@landley.net>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
In-Reply-To: <200511010208.49662.rob@landley.net>
Message-ID: <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
 <20051031192506.100d03fa.akpm@osdl.org> <200511010208.49662.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Rob Landley wrote:

> On Monday 31 October 2005 21:25, Andrew Morton wrote:
> > So I'll queue this up for -mm, but I think we need to see an entire
> > hot-remove implementation based on this, and have all the interested
> > parties signed up to it before we can start moving the infrastructure into
> > mainline.
> >
> > Do you think the features which these patches add should be Kconfigurable?
> 
> Yes please.  At least something under CONFIG_EMBEDDED to save poor Matt the 
> trouble of chopping it out himself. :)

Ok. We will think of something to switch this off.

