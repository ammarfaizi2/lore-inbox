Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753518AbWKCUCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbWKCUCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbWKCUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:02:09 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50609 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753518AbWKCUCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:02:06 -0500
Date: Fri, 3 Nov 2006 14:02:03 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Florin Malita <fmalita@gmail.com>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ecryptfs: bad allocation result check
Message-ID: <20061103200203.GA3572@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <454B9DBA.8030705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454B9DBA.8030705@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 02:51:22PM -0500, Florin Malita wrote:
> The kmalloc() result in* *ecryptfs_crypto_api_algify_cipher_name()
> is assigned to an indirectly referenced pointer and not to the
> pointer itself, so the current result check is incorrect.

Thanks; this bug was already caught and fixed.
