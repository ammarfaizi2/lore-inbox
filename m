Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUJ0HAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUJ0HAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUJ0G5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:57:12 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:46542 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262306AbUJ0Gz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:55:29 -0400
Date: Tue, 26 Oct 2004 23:55:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC] Rename SECTOR_SIZE to IDE_SECTOR_SIZE
Message-ID: <20041027065524.GA1524@taniwha.stupidest.org>
References: <20041027060828.GA32396@taniwha.stupidest.org> <417F4497.3020205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F4497.3020205@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 02:47:51AM -0400, Jeff Garzik wrote:

> It's highly silly to rename the same name + the same value to
> multiple different names.

initially i was going to do that, but when i looked at the code i
realized the problem is some of the users seem to be semantically
different and potentially might want to be changed separate to the
others

> Put it in a common header somewhere, and only rename the oddballs
> (if any).

we could have UNIX_SECTOR_SIZE in blkdev.h but as i said, some users
really are 512 for different reasons that might change (?)
