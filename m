Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWFLDGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFLDGL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 23:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFLDGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 23:06:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8686 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbWFLDGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 23:06:09 -0400
Message-ID: <448CDA1F.7080605@garzik.org>
Date: Sun, 11 Jun 2006 23:06:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2.6.17-rc6] sata_mv: grab host lock inside eng_timeout
References: <200606071253.29745.liml@rtr.ca>
In-Reply-To: <200606071253.29745.liml@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Bug fix:  mv_eng_timeout() calls mv_err_intr() without first grabbing the host lock,
> which can lead to all sorts of interesting scenarios.
> 
> This whole error-handling portion of sata_mv is nasty (and will get fixed for
> the new EH stuff), but for now this patch will help keep it on life-support.
> 
> Signed-off-by:  Mark Lord <liml@rtr.ca>

applied


