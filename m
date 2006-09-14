Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWINVhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWINVhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWINVhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:37:45 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:42217 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751131AbWINVhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:37:43 -0400
Subject: Re: [GIT PATCH] (hopefully) final SCSI fixes for 2.6.19
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <20060914142044.4272fc56.akpm@osdl.org>
References: <1158268378.3514.61.camel@mulgrave.il.steeleye.com>
	 <20060914142044.4272fc56.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 16:37:39 -0500
Message-Id: <1158269859.3514.74.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 14:20 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/fix-panic-when-reinserting-adaptec-pcmcia-scsi-card.patch
> might be handy too.  Your ack is my command.

Well ... no, not really, on the grounds that the patch is wrong.

The correct fix is to eliminate the aha152x_host array by converting the
driver to the correct driver model ... I just haven't had time to look
at doing that yet.

James


