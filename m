Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVIKF4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVIKF4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 01:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVIKF4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 01:56:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7318 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932444AbVIKF4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 01:56:07 -0400
Date: Sun, 11 Sep 2005 06:56:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nfs: add endian annotations
Message-ID: <20050911055604.GI25261@ZenIV.linux.org.uk>
References: <20050910164246.GC23850@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910164246.GC23850@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All 3 merged into -bird; one thing that is probably worth doing is separate
type for server-returned error (always __be32).  That's a large part of
nfs patch, IIRC - separating it would be worth doing.

This stuff should be split before going upstream, IMO - I'll see what I
can do with that.
