Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUIGQl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUIGQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268348AbUIGQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:38:45 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:29703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268200AbUIGQec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:34:32 -0400
Date: Tue, 7 Sep 2004 17:34:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de
Subject: Re: clustering and 2.6
Message-ID: <20040907173427.A17284@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	mikem <mikem@beardog.cca.cpqcorp.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, axboe@suse.de
References: <20040907161254.GA23325@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040907161254.GA23325@beardog.cca.cpqcorp.net>; from mikem@beardog.cca.cpqcorp.net on Tue, Sep 07, 2004 at 11:12:54AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:12:54AM -0500, mikem wrote:
> The SCSI mid-layer sets a bogus size on a device when read capacity fails.
> Is this the preferred way to get around this issue? Seems like there
> should be a better way.

you need to write something (anything works) to the rescan attribute of
each lun.
