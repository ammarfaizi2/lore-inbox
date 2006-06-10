Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWFJQnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWFJQnz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFJQnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:43:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34498 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751649AbWFJQny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:43:54 -0400
Date: Sat, 10 Jun 2006 09:43:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <20060610092412.66dd109f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
 <20060610092412.66dd109f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, Andrew Morton wrote:

> You'll need to disable CONFIG_DEBUG_PREEMPT, sorry.
> 
> Christoph, that is the last straw - I'll drop all these patches.  There's a
> file in -mm Documentation/SubmitChecklist - please tape to to yor monitor.

Would it be possible only the drop the patchset that caused this? 

This seems to be caused by the event counters and not by the zoned VM 
counters. I intentially try to separate these two. There are numerous 
issues still to be resolved for the zoned VM counters. I listed some in 
the header.

> page-flags.h was an inappropriate place for that code.

You mean I should move all the vm counters into separate header and c file 
right?

