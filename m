Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWAFTHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWAFTHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAFTHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:07:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32527 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932492AbWAFTHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:07:18 -0500
Date: Thu, 5 Jan 2006 19:50:30 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp vs. modular IDE (or wherever your swap is)
Message-ID: <20060105195030.GA2581@ucw.cz>
References: <200601061716.31410.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061716.31410.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-01-06 17:16:30, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Do I understand correctly that swsusp requires drivers for primary swap to be 
> compiled in kernel? It appears that initrd-based implementation is possible 
> (load drivers for resume partition and then attempt to do manual resume via 
> "echo x:y > /sys/power/resume") - are there any issues associated with it?

Except that it eats any mounted filesystems? No. Do mounts after
echo and you should be fine.

-- 
Thanks, Sharp!
