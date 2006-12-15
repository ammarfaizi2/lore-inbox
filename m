Return-Path: <linux-kernel-owner+w=401wt.eu-S1750701AbWLOFYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWLOFYw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 00:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWLOFYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 00:24:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33415 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbWLOFYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 00:24:51 -0500
Date: Thu, 14 Dec 2006 21:24:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce time_data, a new structure to hold jiffies,
 xtime, xtime_lock, wall_to_monotonic, calc_load_count and avenrun
Message-Id: <20061214212435.e2f90a73.akpm@osdl.org>
In-Reply-To: <200612132226.26535.dada1@cosmosbay.com>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<20061207095715.0cafffb9.akpm@osdl.org>
	<200612081752.09749.dada1@cosmosbay.com>
	<200612132226.26535.dada1@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 22:26:26 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> This patch introduces a new structure called time_data, where some time 
> keeping related variables are put together to share as few cache lines as 
> possible.

ia64 refers to xtime_lock from assembly and hence doesn't link.
