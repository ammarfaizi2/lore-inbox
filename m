Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUB1V2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUB1V2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:28:36 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:33766 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261924AbUB1V2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:28:35 -0500
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <404106D7.8050809@pobox.com>
References: <4040E7B5.4020709@pobox.com>
	<1078001357.2020.90.camel@mulgrave>  <404106D7.8050809@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Feb 2004 15:28:31 -0600
Message-Id: <1078003712.2020.92.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 15:23, Jeff Garzik wrote:
> Yeah, that's much better.  That function is not exported though ;-)

I can fix that.  It really is a necessary function for drivers doing
their own strategy handler ... of which yours seems to be the only one.

James


