Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269643AbUJGOHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269643AbUJGOHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUJGOHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:07:16 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:30473 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266175AbUJGOHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:07:10 -0400
Date: Thu, 7 Oct 2004 15:07:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Lord <lsml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
Message-ID: <20041007150709.B12688@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Lord <lsml@rtr.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <416547B6.5080505@rtr.ca>; from lsml@rtr.ca on Thu, Oct 07, 2004 at 09:42:14AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 09:42:14AM -0400, Mark Lord wrote:
> Okay, last call for comment on this driver.
> 
> Any other issues before initial kernel inclusion?

Yes, there's lots of issues, but I need some time to write them all up.
You could start by removing all the silly typedefs and the EXPORT_SYMBOLs
that have been vetoed.

