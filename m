Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUIVJOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUIVJOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUIVJOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 05:14:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56591 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263100AbUIVJO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 05:14:28 -0400
Date: Wed, 22 Sep 2004 10:14:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shobhit Mathur <shobhitmmathur@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI /proc query ...
Message-ID: <20040922101426.A381@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shobhit Mathur <shobhitmmathur@yahoo.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20040922062305.52594.qmail@web52507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040922062305.52594.qmail@web52507.mail.yahoo.com>; from shobhitmmathur@yahoo.com on Tue, Sep 21, 2004 at 11:23:05PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 11:23:05PM -0700, Shobhit Mathur wrote:
> Hello,
> 
> I intend to implement /proc interface for a SCSI HBA.

Don't do that.  We're not going to take new drivers that implement ->proc_info
anymore.

