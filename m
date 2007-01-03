Return-Path: <linux-kernel-owner+w=401wt.eu-S1755008AbXACIJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbXACIJ1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbXACIJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:09:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51750 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008AbXACIJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:09:26 -0500
Date: Wed, 3 Jan 2007 00:09:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] 4/4 block: explicit plugging
Message-Id: <20070103000909.dc70594f.akpm@osdl.org>
In-Reply-To: <1167810508576-git-send-email-jens.axboe@oracle.com>
References: <11678105083001-git-send-email-jens.axboe@oracle.com>
	<1167810508576-git-send-email-jens.axboe@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Jan 2007 08:48:28 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:

> This is a patch to perform block device plugging explicitly in the submitting
> process context rather than implicitly by the block device.

I don't think anyone will regret the passing of address_space_operations.sync_page().

Do you have any benchmarks which got faster with these changes?
