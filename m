Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVDGL2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVDGL2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVDGL1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:27:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31975 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262438AbVDGLYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:24:16 -0400
Date: Thu, 7 Apr 2005 12:24:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] Use proper seq_file api for /proc/scsi/scsi
Message-ID: <20050407112412.GA12072@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <42550173.1040503@suse.de> <20050407103123.GB9586@infradead.org> <425517B3.2010702@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425517B3.2010702@suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:21:23PM +0200, Hannes Reinecke wrote:
> > /proc/scsi/scsi is deprecated and even only compiled in if
> > "legacy /proc/scsi/ support" is enabled.  Please move over to lssci which
> > is using sysfs ASAP.
> > 
> Ah. And that's enough reason for it not to work properly?
> Deprecated as it may be, but one could at least expect it to _work_.

It works for those setups that already worked with 2.4.x, aka only a few
luns.

