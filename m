Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWA0Bgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWA0Bgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWA0Bgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:36:39 -0500
Received: from xenotime.net ([66.160.160.81]:50386 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932283AbWA0Bgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:36:38 -0500
Date: Thu, 26 Jan 2006 17:36:50 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@muc.de>
Cc: ashok.raj@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kaos@sgi.com, randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-Id: <20060126173650.51496925.rdunlap@xenotime.net>
In-Reply-To: <20060126042603.GA88680@muc.de>
References: <20060125120253.A30999@unix-os.sc.intel.com>
	<20060126042603.GA88680@muc.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 2006 05:26:03 +0100 Andi Kleen wrote:

> On Wed, Jan 25, 2006 at 12:02:53PM -0800, Ashok Raj wrote:
> > Hi Andrew
> > 
> > attached patch is 2 more cases i found via running the reference_init.pl
> > script. These were easy to spot just knowing the file names. There is 
> > one another about init/main.c that i cant exactly zero in. (partly 
> > because i dont know how to interpret the data thats spewed out of the tool).
> 
> I think that's the reference to __initcall_start / end 
> That one is unavoidable, but not a bug.

Yes, that's the conclusion that I came to also.

---
~Randy
