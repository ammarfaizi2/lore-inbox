Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVJUP3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVJUP3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVJUP3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:29:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4774 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964982AbVJUP3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:29:31 -0400
Date: Fri, 21 Oct 2005 08:28:49 -0700
From: Paul Jackson <pj@sgi.com>
To: mike kravetz <kravetz@us.ibm.com>
Cc: akpm@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-Id: <20051021082849.45dafd27.pj@sgi.com>
In-Reply-To: <20051020234621.GL5490@w-mikek2.ibm.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020160638.58b4d08d.akpm@osdl.org>
	<20051020234621.GL5490@w-mikek2.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike wrote:
> Just to be clear, there are at least two distinct requirements for hotplug.
> One only wants to remove a quantity of memory (location unimportant). 

Could you describe this case a little more?  I wasn't aware
of this hotplug requirement, until I saw you comment just now.

The three reasons I knew of for wanting to move memory pages were:
 - offload some physical ram or node (avoid or unplug bad hardware)
 - task migration to another cpuset or moving an existing cpuset
 - various testing and performance motivations to optimize page location

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
