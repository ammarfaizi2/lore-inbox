Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933283AbWKNA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbWKNA7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933292AbWKNA7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:59:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933283AbWKNA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:59:45 -0500
Date: Mon, 13 Nov 2006 16:59:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cmm@us.ibm.com,
       val_henson@linux.intel.com
Subject: Re: [PATCH] Bring ext2 reservations code in line with latest ext3
Message-Id: <20061113165939.429e53a4.akpm@osdl.org>
In-Reply-To: <4557BFD7.5010405@mbligh.org>
References: <200611090841.kA98feVx010502@shell0.pdx.osdl.net>
	<4557BFD7.5010405@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 16:44:07 -0800
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> Only thing left remaining was the error handling in
> ext2_try_to_allocate_with_rsv, but it may be OK as is.

yes, it looks OK.  ext3 has to do extra journalling things.
