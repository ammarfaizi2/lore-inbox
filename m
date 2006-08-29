Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWH2HQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWH2HQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWH2HQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:16:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63151 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932156AbWH2HQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:16:02 -0400
Date: Tue, 29 Aug 2006 00:15:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nathanl@austin.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ntl@pobox.com, y-goto@jp.fujitsu.com, anton@samba.org,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH] cpuset: hotunplug cpus and mems in all cpusets
Message-Id: <20060829001512.36839323.pj@sgi.com>
In-Reply-To: <20060828231917.6f4bb9af.akpm@osdl.org>
References: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
	<20060828231917.6f4bb9af.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Did you consider failing the hotremove request instead?

Eh ... we'd end up with another complaint from the hotplug
folks, in another year, when some obscure constraint on
nested cpusets thwarted their efforts to unplug something.

It's best if cpusets just deals with it somehow, and doesn't
complain about the comings and goings of hardware.

At least, that's my take on it ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
