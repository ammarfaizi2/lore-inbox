Return-Path: <linux-kernel-owner+w=401wt.eu-S1161180AbXAHSe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbXAHSe1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbXAHSe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:34:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33621 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161180AbXAHSe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:34:26 -0500
Date: Mon, 8 Jan 2007 10:34:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: kallsyms_lookup export in -mm
Message-Id: <20070108103417.5bb5af26.akpm@osdl.org>
In-Reply-To: <20070108133036.GA18681@infradead.org>
References: <20070108133036.GA18681@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 13:30:36 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> This beast definitly shouldn't be exported.  drivers/mtd/ubi/debug.c
> should probably be just removed instead - it's an utter mess anyway.

I think that's happening.  Partially, at least.
