Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbVBDOz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbVBDOz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbVBDOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:50:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:57819 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S265682AbVBDOph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:45:37 -0500
Date: Fri, 4 Feb 2005 07:45:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       benh@kernel.crashing.org, hpa@zytor.com, akpm@osdl.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Message-ID: <20050204144532.GN15359@smtp.west.cox.net>
References: <20050204072254.GA17565@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 01:22:54AM -0600, Olof Johansson wrote:

> Hi,
> 
> It's getting pretty old to have see and type cur_cpu_spec->cpu_features
> & CPU_FTR_<feature>, when a shorter and less TLA-ridden macro is more
> readable.
> 
> This also takes care of the differences between PPC and PPC64 cpu
> features for the common code; most places in PPC could be replaced with
> the macro as well.

It'd be nice if someone went and changed ppc32's cpu feature from an
array and matched ppc64, while we're in here...

-- 
Tom Rini
http://gate.crashing.org/~trini/
