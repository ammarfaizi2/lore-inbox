Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJXRZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJXRZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVJXRZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:25:53 -0400
Received: from mail.fieldses.org ([66.93.2.214]:13983 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751157AbVJXRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:25:53 -0400
Date: Mon, 24 Oct 2005 13:25:46 -0400
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] FUSE: per inode statfs
Message-ID: <20051024172546.GA30782@fieldses.org>
References: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 07:16:29PM +0200, Miklos Szeredi wrote:
> This patch makes FUSE based filesystems able to return filesystem
> statistics based on path.  While breaks with the tradition of
> homogeneous statistics per _local_ filesystem, however adds useful
> ability to user to differentiate statistics from different _remote_
> filesystem served by the same userspace server.

Wouldn't it make more sense to create more mountpoints (on demand, if
necessary) to handle this case?

--b.
