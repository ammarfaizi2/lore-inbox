Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266363AbUGJTqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUGJTqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGJTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:46:38 -0400
Received: from host84.200-117-131.telecom.net.ar ([200.117.131.84]:1195 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S266363AbUGJTqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:46:37 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: XFS: how to NOT null files on fsck?
Date: Sat, 10 Jul 2004 16:46:27 -0300
User-Agent: KMail/1.6.2
Cc: Chris Wedgwood <cw@f00f.org>, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <je658vwtbl.fsf@sykes.suse.de>
In-Reply-To: <je658vwtbl.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407101646.27067.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> writes:
> > Chris Wedgwood wrote:
> >> XFS does not journal data.
> >
> > I think we all know that. The point, why the hell does it null files?
>
> Security.  You don't want old contents of /etc/shadow appear in random
> files after a crash.

Wow. You're telling me that XFS doesn't know if a given piece of the log is 
from file-a or file-b and just in case it zeroes its contents? 

If that's true, XFS has moved to my never-ever-use-it-again list.

Thanks,
Norberto
