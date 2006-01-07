Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWAGXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWAGXax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWAGXaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:30:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31408 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161052AbWAGXav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:30:51 -0500
Date: Sat, 7 Jan 2006 23:30:46 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/libfs.c: unexport simple_rename
Message-ID: <20060107233046.GE27946@ftp.linux.org.uk>
References: <20060107215134.GX3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107215134.GX3774@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 10:51:34PM +0100, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(simple_rename).

fatal error: engage your brain or sod off.

Let me put it that way: libfs is a fscking _library_.  Exported symbols
there are exported for purpose; presense or absense of current modular
users does not matter.
