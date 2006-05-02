Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWEBPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWEBPEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEBPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:04:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:49324 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964864AbWEBPEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:04:52 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 17:03:36 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org>
In-Reply-To: <44576688.6050607@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021703.37195.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 16:02, Martin J. Bligh wrote:
> > Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
> > anywhere but some Summit systems (at least every time I tried it it blew up 
> > on me and nobody seems to use it regularly). Maybe it would be finally time to mark it 
> > CONFIG_BROKEN though or just remove it (even by design it doesn't work very well) 
> 
> Bollocks. It works fine, 

On what kind of box? Some summit system, right?

> and is tested every single day, on every git 
> release, and every -mm tree.

Well, it doesn't work for Ingo clearly. My own experiences every time
I tried it were similar.

I think I stand by my original statement.

-Andi

