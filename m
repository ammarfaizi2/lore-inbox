Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWFIXEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWFIXEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFIXEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030276AbWFIXEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:04:32 -0400
Date: Fri, 9 Jun 2006 16:07:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Re: Light weight counter 1/1 Framework
Message-Id: <20060609160730.5a67ae6b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091537350.3036@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
	<20060609143333.39b29109.akpm@osdl.org>
	<Pine.LNX.4.64.0606091537350.3036@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Eventcounter fixups

This is getting to be a bit of a pain.  Could you please spend more time
reviewing and testing patches before sending them?

Says he, staring at this:

mm/page_alloc.c: In function 'page_alloc_cpu_notify':
mm/page_alloc.c:2891: error: 'per_cpu__page_states' undeclared (first use in this function)

