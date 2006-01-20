Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161500AbWATEh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161500AbWATEh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161501AbWATEh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:37:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161500AbWATEh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:37:56 -0500
Date: Thu, 19 Jan 2006 20:37:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com
Subject: Re: [PATCH] tpm_infineon: fix printk format warning
Message-Id: <20060119203730.4934a1c8.akpm@osdl.org>
In-Reply-To: <20060119202458.367279b8.rdunlap@xenotime.net>
References: <20060119202458.367279b8.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> -				"Could not set IO-ports to %04x\n",
>  +				"Could not set IO-ports to %lx\n",
>  

I stuck a "0x" in there too.
