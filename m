Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTGMNIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbTGMNIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:08:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:27540 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265772AbTGMNIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:08:39 -0400
Date: Sun, 13 Jul 2003 14:23:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030713132322.GB19132@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk> <16141.15245.367725.364913@charged.uio.no> <20030710150012.GA29113@mail.jlokier.co.uk> <16141.32852.39625.891724@charged.uio.no> <20030710153557.GD29113@mail.jlokier.co.uk> <16141.63602.314666.241727@charged.uio.no> <20030712151343.GA9483@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712151343.GA9483@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> I haven't tried this yet.  It doesn't apply to 2.5.74 due to the calls
> to io_schedule().

I've tried both patches together now, on 2.5.75.  Still seeing fast
(<0.1s) timeouts with "soft".  Using "hard" seems fairly reliable, but
that was the same without the patches.

-- Jamie
