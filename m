Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWA3LvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWA3LvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWA3LvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:51:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63724 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932230AbWA3LvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:51:16 -0500
Date: Mon, 30 Jan 2006 12:50:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Message-ID: <20060130115058.GB1705@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601280520.28816.nigel@suspend2.net> <20060127232251.GC1617@elf.ucw.cz> <200601301554.54710.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601301554.54710.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 30-01-06 15:54:49, Nigel Cunningham wrote:
> Hi.
> 
> On Saturday 28 January 2006 09:22, Pavel Machek wrote:
> > You could swapoff -a to make your cycle a lot faster.... Freezing is
> > still done in that case, IIRC.
> 
> That was right. I just did the test:
> 
> I used
> 
> stress -d 5 --hdd-bytes 100M -i 5 -c 5
> 
> to test.

Quite easy to reproduce, indeed. I'll try to find out if simple
solution exists. (Notice that we still have that famous mysqld bug. I
still have testcase somewhere).
								Pavel
-- 
Thanks, Sharp!
