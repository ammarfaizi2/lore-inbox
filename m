Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUCPCwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUCPCwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:52:15 -0500
Received: from dp.samba.org ([66.70.73.150]:47064 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262890AbUCPCoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:44:39 -0500
Date: Tue, 16 Mar 2004 13:39:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kenneth Chen <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch - make config_max_raw_devices work
Message-ID: <20040316023946.GO19737@krispykreme>
References: <200403160053.i2G0rNm31241@unix-os.sc.intel.com> <20040315181406.2f2d8f38.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315181406.2f2d8f38.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Badari wrote basically the same patch a couple of months back.  I dropped
> it then, too ;)
> 
> raw is a deprecated interface and if we keep on adding new features to it,
> we will never be rid of the thing.  If your application requires more than
> 256 raw devices, please convert it to open the block device directly,
> passing in the O_DIRECT flag.

We only deprecated this thing on the 4th Feb 2004. I want to see the raw
driver die but we cant expect apps to change their interfaces in the space
of a month.

Can we reach a compromise? :)

Anton
