Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWA1AgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWA1AgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWA1AgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:36:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422758AbWA1AgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:36:01 -0500
Date: Fri, 27 Jan 2006 16:38:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/11] sh: Make peripheral clock frequency setting
 mandatory.
Message-Id: <20060127163802.3bac2520.akpm@osdl.org>
In-Reply-To: <20060127225053.GC30816@linux-sh.org>
References: <20060127224919.GA30816@linux-sh.org>
	<20060127225053.GC30816@linux-sh.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:
>
> +	BUG_ON(unlikely(!master_clk.rate));

BUG_ON() already does unlikely().
