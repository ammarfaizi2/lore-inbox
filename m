Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUKOAHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUKOAHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUKOAHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:07:19 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:49629 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261378AbUKOAGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:06:23 -0500
Subject: Re: [BK PATCH] SCSI -rc1 fixes
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m3hdnsvvfd.fsf@merlin.emma.line.org>
References: <1100467267.23710.7.camel@mulgrave>
	<4197E4B7.3050008@pobox.com> <1100473795.23649.26.camel@mulgrave> 
	<m3hdnsvvfd.fsf@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Nov 2004 18:04:58 -0600
Message-Id: <1100477105.24921.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-14 at 17:54, Matthias Andree wrote:
> Still wondering about SuSE's hwscan issue. Has someone managed to figure
> if it uses some ioctl that chokes the sym2 driver or if it hacks the
> hardware?

Well, I think we're stuck on that one.  SUSE doesn't seem willing to
debug hwscan enough to give a coherent description of the problem or a
non hwscan test case and no-one else wants to take hwscan apart to find
out exactly what it is doing.

James


