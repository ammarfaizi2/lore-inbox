Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWEWX0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWEWX0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWEWX0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:26:01 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16422 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932472AbWEWX0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:26:00 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=HLVBzblGEWCPOLgUlZlwn8GmzL7MaVQzAxzaGZZSqOefNwdzoAZknYwsby4WbHQao
	4vbBbo0A5Nut0gpyO5+Pg==
Subject: Re: [PATCH]x86_64: moving phys_proc_id and cpu_core_id to
	cpuinfo_x86
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605240121.39667.ak@suse.de>
References: <1148424226.5959.18.camel@galaxy.corp.google.com>
	 <200605240121.39667.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 23 May 2006 16:25:30 -0700
Message-Id: <1148426730.5959.20.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 01:21 +0200, Andi Kleen wrote:
> On Wednesday 24 May 2006 00:43, Rohit Seth wrote:
> > 
> > Most of the fields of cpuinfo are defined in cpuinfo_x86 structure.
> > This patch moves the phys_proc_id and cpu_core_id for each processor to
> > cpuinfo_x86 structure as well.
> 
> Added thanks. At some point it'll probably change again because
> I hope to eventually move cpuinfo into the x86-64 PDA, but not right now.
> 
Yup.

> For symmetry it might be a good idea to do a similar patch for i386 too.
> 

I will do that.


-rohit

