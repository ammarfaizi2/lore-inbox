Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWFAIqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFAIqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFAIqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:46:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWFAIqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:46:46 -0400
Date: Thu, 1 Jun 2006 01:50:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: tim.bird@am.sony.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
Message-Id: <20060601015059.56d5953f.akpm@osdl.org>
In-Reply-To: <447EA800.101@de.ibm.com>
References: <1148055080.2974.15.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<4474CD38.5090206@am.sony.com>
	<447EA800.101@de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 10:40:32 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> Or, Andrew, do you prefer a replacement patch for my
> statistics-infrastructure-prerequisite-timestamp.patch
> that introduces this miscalculation. I could put
> statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
> into that one as well, so that all the timestamp related printk-changes are in
> one place.

umm, finest-possible-granularity patches against rc5-mm2 would be preferred
if poss.  I have scripts and tricks to do the topolgical patchsort so that
things end up in a logical patch series.

