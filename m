Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVDXH0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVDXH0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVDXH0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:26:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65005 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262279AbVDXH0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:26:14 -0400
Date: Sun, 24 Apr 2005 08:26:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/FlashPoint.c: cleanups
Message-ID: <20050424072610.GA13662@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050423221712.GJ4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423221712.GJ4355@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 12:17:12AM +0200, Adrian Bunk wrote:
> This patch contains cleanups including the following:
> - remove #ifdef'ed code for other OS's
> - remove other unused code
> - make needlessly global code static

I'd rather not touch this file currently.  It's glued toghether from
lots of separate files in the original code.  Before doing cleanups
I'd rather split it into all these files first as the file is a huge
mess as-is.

