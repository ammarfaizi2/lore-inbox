Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTENFpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTENFpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:45:06 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:16143 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261399AbTENFpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:45:06 -0400
Date: Wed, 14 May 2003 06:57:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Message-ID: <20030514065752.A647@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christopher Hoover <ch@murgatroid.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030513202710.A32666@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513202710.A32666@heavens.murgatroid.com>; from ch@murgatroid.com on Tue, May 13, 2003 at 08:29:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:29:20PM -0700, Christopher Hoover wrote:
> Unless I'm missing something, there doesn't seem to be a good reason
> for the block system to include SCSI ioctls unless there's a SCSI
> block device (CONFIG_BLK_DEV_SD) in the system.

That's broken.  You can use them on ide, sd and sr currently.

