Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTKKWoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTKKWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:44:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:9144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263819AbTKKWoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:44:37 -0500
Date: Tue, 11 Nov 2003 14:48:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       ak@suse.de
Subject: Re: [PATCH] zero out i_blocks in get_pipe_inode
Message-Id: <20031111144842.137e396e.akpm@osdl.org>
In-Reply-To: <44940000.1068591898@flay>
References: <44940000.1068591898@flay>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
>  +	inode->i_blocks = 0;

alloc_inode() already did that.
