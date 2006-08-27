Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWH0VVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWH0VVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWH0VVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:21:39 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:62850 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932294AbWH0VVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:21:38 -0400
Date: Sun, 27 Aug 2006 14:21:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Howells <dhowells@redhat.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] [PATCH] BLOCK: Don't call block_sync_page() from AFS [try #4]
Message-ID: <20060827212136.GA12710@tuatara.stupidest.org>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:37:10PM +0100, David Howells wrote:

> The AFS filesystem specifies block_sync_page() as its sync_page
> address op, which needs to be checked, and so is commented out for
> the moment.

Wouldn't it be better to just let the link/build fail so someone who
groks AFS internals can look into this?

