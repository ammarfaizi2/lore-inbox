Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUJNSzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUJNSzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJNSwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:52:18 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:5382 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267319AbUJNSkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:40:09 -0400
Date: Thu, 14 Oct 2004 19:39:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
Message-ID: <20041014183948.GA12325@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	mikem@beardog.cca.cpqcorp.net, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net> <20041014083900.GB7747@infradead.org> <1097764660.2198.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097764660.2198.11.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:37:32AM -0500, James Bottomley wrote:
> I don't think so ... it's a volume you know exists but you can't get
> access to (in a shared storage configuration).  In SCSI we have two
> examples of this now:

Such a volume has been configured and set up, and although it's still
ugly I'd say it's okay.  But the patch also adds one gendisk per controller
even if no volume is set up.

