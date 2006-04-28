Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWD1HeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWD1HeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWD1HeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:34:16 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11932 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030294AbWD1HeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:34:16 -0400
Date: Fri, 28 Apr 2006 03:33:58 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
Message-ID: <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>
References: <20060424150544.GL15613@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424150544.GL15613@skybase>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 05:05:44PM +0200, Martin Schwidefsky wrote:
> +++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
...
> +#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */

I'm no s390 expert, but shouldn't the above use something like HZ?

Josef 'Jeff' Sipek.
