Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTKKXLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTKKXLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:11:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50073 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263805AbTKKXLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:11:14 -0500
Date: Tue, 11 Nov 2003 15:36:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       ak@suse.de
Subject: Re: [PATCH] zero out i_blocks in get_pipe_inode
Message-ID: <51260000.1068593774@flay>
In-Reply-To: <20031111144842.137e396e.akpm@osdl.org>
References: <44940000.1068591898@flay> <20031111144842.137e396e.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  +	inode->i_blocks = 0;
> 
> alloc_inode() already did that.

Sigh ... yes, you're right - sorry.

get_pipe_inode -> new_inode -> alloc_inode. definitely covered.

I shall crawl back under my regularly scheduled stone ;-)

M.

