Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUE1HUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUE1HUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 03:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUE1HUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 03:20:35 -0400
Received: from [213.146.154.40] ([213.146.154.40]:691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262905AbUE1HUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 03:20:34 -0400
Date: Fri, 28 May 2004 08:20:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Aubin <daubin@actuality-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Message-ID: <20040528072030.GA24992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Aubin <daubin@actuality-systems.com>,
	linux-kernel@vger.kernel.org
References: <200405271736.08288.dj@david-web.co.uk> <200405271854.20787.dj@david-web.co.uk> <1085680806.5311.44.camel@buffy> <200405271925.24650.dj@david-web.co.uk> <1085695702.10106.65.camel@buffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085695702.10106.65.camel@buffy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:08:23PM -0400, David Aubin wrote:
> Hi Dave,
> 
>   You do not have devfs enabled.  So root=/dev/hda3
> should not work.  Please enable in kernel and retry.
> 
> # CONFIG_DEVFS_FS is not set

Exactly the wrong way around.  If you're brave enough to use
devfs you need to use devfs names on the command line.
