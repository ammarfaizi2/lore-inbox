Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUAUFEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 00:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUAUFEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 00:04:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63676 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261827AbUAUFEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 00:04:51 -0500
Date: Wed, 21 Jan 2004 10:39:33 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Tim Hockin <thockin@hockin.org>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040121103933.B3236@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400DFC8B.7020906@cyberone.com.au>; from piggin@cyberone.com.au on Wed, Jan 21, 2004 at 03:14:03PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:14:03PM +1100, Nick Piggin wrote:
> Yes, that is with the cpu-is-down hotplug event, right?

right.

 
> *Before* that happens, tasks that don't handle the signal should just
> have their affinity changed to all cpus.

Currently, handle or not handle the signal, affinity is changed
to all cpus for tasks that are bound only to the dying CPU.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
