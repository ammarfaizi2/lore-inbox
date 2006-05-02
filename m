Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWEBQFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWEBQFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWEBQFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:05:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:22423 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964909AbWEBQFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:05:19 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 18:05:14 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
References: <20060419112130.GA22648@elte.hu> <200605021745.32907.ak@suse.de> <4457829E.6090901@mbligh.org>
In-Reply-To: <4457829E.6090901@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021805.14525.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 18:02, Martin J. Bligh wrote:

>  >
>  > i only booted it on a non-NUMA PC. Most likely the instability is
>  > caused by some sort of zone mis-sizing. (See more details in this
>  > same thread.)
> 
> Ooooh, on ordinary PCs. that makes more sense.

It tends to crash on Opteron NUMA systems too.

-Andi
