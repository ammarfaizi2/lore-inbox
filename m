Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUJ0Uh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUJ0Uh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUJ0UdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:33:02 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:24781 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262671AbUJ0U3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:29:48 -0400
Date: Wed, 27 Oct 2004 13:29:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Rename SECTOR_SIZE to BIO_SECTOR_SIZE
Message-ID: <20041027202924.GA20572@taniwha.stupidest.org>
References: <20041027060828.GA32396@taniwha.stupidest.org> <417F4497.3020205@pobox.com> <20041027065524.GA1524@taniwha.stupidest.org> <20041027072212.GN15910@suse.de> <20041027190523.GA19330@taniwha.stupidest.org> <20041027202733.GG28904@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027202733.GG28904@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:27:33PM -0500, Matt Mackall wrote:

> So shouldn't this be in bio.h now?

in a sense, nobody else but IDE uses it, and i just noticed
SECTOR_WORDS is pretty much pointless so i can rediff fixing that
too...
