Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262188AbSJASvw>; Tue, 1 Oct 2002 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSJASuw>; Tue, 1 Oct 2002 14:50:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25604 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262128AbSJASuC>;
	Tue, 1 Oct 2002 14:50:02 -0400
Date: Tue, 1 Oct 2002 20:55:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Miroslav Rudisin <miero@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] default file permission for vfat
Message-ID: <20021001185526.GA704@alpha.home.local>
References: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 07:39:08PM +0200, Miroslav Rudisin wrote:
> Hi,
> 
> The attached patch change default permission of files on [v]fatfs.
> Default RWX have no utilization. This patch remove exec flag.

Hi !

This is sometimes very useful to put init scripts on a floppy disk. I'd
prefer to keep exec flags. If you don't want files to be executable, you
still can mount the FS with the 'noexec' option.

Cheers,
Willy
