Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268245AbUHXTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268245AbUHXTjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268252AbUHXTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:39:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:23682 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268245AbUHXTjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:39:42 -0400
Subject: Re: [PATCH][0/7] xattr consolidation and support for ramfs & tmpfs
From: Andreas Gruenbacher <agruen@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0408231408030.13728-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0408231408030.13728-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1093376475.20259.112.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 21:41:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 20:14, James Morris wrote:
> This series of patches consolidates some common xattr logic into libfs,
> saving significant code duplication and making it easier for filesystem
> writers to implement xattr support.
> 
> The ext3, ext2 and devpts filesytems are then converted to use the new
> API, and xattr support is added to ramfs and tmpfs.

That's a nice improvement.

