Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVB1V3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVB1V3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVB1V3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:29:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55532 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261752AbVB1V3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:29:30 -0500
Date: Mon, 28 Feb 2005 21:29:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: andrew.vasquez@qlogic.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/: cleanups
Message-ID: <20050228212920.GA18162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, andrew.vasquez@qlogic.com,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050228210024.GM4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228210024.GM4021@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 10:00:24PM +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make needlessly global code static
> - kill the unused global *_version and *_version_str variables
>   in the firmware files

The firmware files are generated, so it'd be better to leave them
alone.
