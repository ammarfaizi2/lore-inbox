Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUGWDYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUGWDYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUGWDYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:24:07 -0400
Received: from host85.200-117-133.telecom.net.ar ([200.117.133.85]:25237 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S267517AbUGWDXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:23:50 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: raidstart used deprecated START_ARRAY ioctl
Date: Fri, 23 Jul 2004 00:22:46 -0300
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org
References: <200407090135.12493.norberto+linux-kernel@bensa.ath.cx> <200407090230.24696.norberto+linux-kernel@bensa.ath.cx> <16640.33197.366067.554037@cse.unsw.edu.au>
In-Reply-To: <16640.33197.366067.554037@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407230022.46140.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Friday July 9, norberto+linux-kernel@bensa.ath.cx wrote:
> > Did I get that right? Can I get rid of raidstart and the array will be
> > "assembled by the kernel"?
>
> Yes.  If all the components of the arrays are in partitions with type
> 0xFD, and the md driver and raid personalities are compiled into the
> kernel (not modules), then the kernel will automatically start the
> arrays for you.

Thanks Neil!!

Actually, after I sent that e-mail, I tried it myself and it worked like a 
charm.

With best regards,
Norberto
