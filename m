Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWEWXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWEWXWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEWXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:22:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61867 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932477AbWEWXWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:22:37 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]x86_64: moving phys_proc_id and cpu_core_id to cpuinfo_x86
Date: Wed, 24 May 2006 01:21:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1148424226.5959.18.camel@galaxy.corp.google.com>
In-Reply-To: <1148424226.5959.18.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240121.39667.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 00:43, Rohit Seth wrote:
> 
> Most of the fields of cpuinfo are defined in cpuinfo_x86 structure.
> This patch moves the phys_proc_id and cpu_core_id for each processor to
> cpuinfo_x86 structure as well.

Added thanks. At some point it'll probably change again because
I hope to eventually move cpuinfo into the x86-64 PDA, but not right now.

For symmetry it might be a good idea to do a similar patch for i386 too.

-Andi
