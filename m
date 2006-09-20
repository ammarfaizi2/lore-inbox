Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWITTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWITTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWITTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:51:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22435 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932347AbWITTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:51:23 -0400
Date: Wed, 20 Sep 2006 12:51:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org, pj@sgi.com,
       npiggin@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158775678.8574.81.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201248510.32409@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158773208.8574.53.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
 <1158775678.8574.81.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> I thought the fake NUMA support still does not work on x86_64 baseline
> kernel.  Though Paul and Andrew have patches to make it work.

Read linux-mm. There is work in progress.

> > This is commonly discussed under the subject of memory hotplug.
> So now we depend on getting memory hot-plug to work for faking up these
> nodes ...for the memory that is already present in the system. It just
> does not sound logical.

It is logical since nodes are containers of memory today and we have 
established VM functionality to deal with these containers. If you read 
the latest linx-mm then you will find that this was tested and works fine.

