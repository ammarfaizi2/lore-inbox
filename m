Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWAZE0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWAZE0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZE0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:26:12 -0500
Received: from colin.muc.de ([193.149.48.1]:64006 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750778AbWAZE0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:26:11 -0500
Date: 26 Jan 2006 05:26:03 +0100
Date: Thu, 26 Jan 2006 05:26:03 +0100
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kaos@sgi.com,
       randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-ID: <20060126042603.GA88680@muc.de>
References: <20060125120253.A30999@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125120253.A30999@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:02:53PM -0800, Ashok Raj wrote:
> Hi Andrew
> 
> attached patch is 2 more cases i found via running the reference_init.pl
> script. These were easy to spot just knowing the file names. There is 
> one another about init/main.c that i cant exactly zero in. (partly 
> because i dont know how to interpret the data thats spewed out of the tool).

I think that's the reference to __initcall_start / end 
That one is unavoidable, but not a bug.

-Andi
