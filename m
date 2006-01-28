Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422818AbWA1DDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWA1DDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWA1DDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:03:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:29886 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbWA1DDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:03:31 -0500
From: Andi Kleen <ak@suse.de>
To: Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH 1/2] [x86-64] align per-cpu section to configured cache bytes
Date: Sat, 28 Jan 2006 04:03:10 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601280403.11270.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 23:02, Zach Brown wrote:
> [x86-64] align per-cpu section to configured cache bytes
> 
> Align the start of the per-cpu section to the configured number of bytes in a
> cache line.  This stops a BUG_ON() from triggering in load_module() when
> DEFINE_PER_CPU() is used in a module and the section isn't cacheline-aligned.
> Rusty also found this and sent a patch in a while ago
> (http://lkml.org/lkml/2004/10/19/17), I don't know what came of that.

Added. 

-Andi
