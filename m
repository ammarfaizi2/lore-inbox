Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWIRSxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWIRSxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIRSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:53:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932093AbWIRSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:53:47 -0400
Date: Mon, 18 Sep 2006 19:53:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi-driver ultrastore replace Scsi_Cmnd with struct scsi_cmnd
Message-ID: <20060918185321.GB17670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henne <henne@nachtwindheim.de>, Andrew Morton <akpm@osdl.org>,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <44FE8BAC.1030004@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FE8BAC.1030004@nachtwindheim.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 10:49:48AM +0200, Henne wrote:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Replaces the typedef'd Scsi_Cmnd with struct scsi_cmnd.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Looks good to me.  It would be even better if you could update the
driver to not require

	#include "scsi.h"

anymore and get rid of ultrastor.h.  Also your mailer unfortunately
damages tabs.

