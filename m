Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTEDOtt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTEDOtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:49:49 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11525 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263623AbTEDOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:49:47 -0400
Subject: Re: Regarding Umount
From: James Bottomley <James.Bottomley@steeleye.com>
To: nmala@mail.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20030504145234.83566.qmail@mail.com>
References: <20030504145234.83566.qmail@mail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 May 2003 09:58:28 -0500
Message-Id: <1052060310.10809.17.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 09:52, nmala@mail.com wrote:
> What exactly does umount write?? Every time I umount my pseudo driver there are two calls to request with readwrite flag set to 1. Haven't been able to find a corresponding write in the trace of umount.

That depends on the fs.  One will almost certainly be the final
superblock update.

James


