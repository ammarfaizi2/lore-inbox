Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbUJYPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUJYPOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUJYPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:13:48 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:57356 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261922AbUJYPEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:04:53 -0400
Date: Mon, 25 Oct 2004 16:04:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 8/28] VFS: Remove MNT_EXPIRE support
Message-ID: <20041025150446.GB1603@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987153211852@sun.com> <10987153522992@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987153522992@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:42:32AM -0400, Mike Waychison wrote:
> Drop support for MNT_EXPIRE (flag to umount(2)).  Nobody was using it and it
> didn't fit into the new expiry framework.

umm, this is a user API, you can't simply drop it.

