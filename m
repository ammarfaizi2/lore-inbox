Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWAXQrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWAXQrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWAXQrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:47:24 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:64739 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964998AbWAXQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:47:23 -0500
Date: Tue, 24 Jan 2006 11:22:44 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH] SMP alternatives
In-reply-to: <43D648CC.4090101@suse.de>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <1138119764.4207.7.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <43D648CC.4090101@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 16:33 +0100, Gerd Hoffmann wrote:
>   Hi Andrew,
> 
> Can you include the patch in -mm to give it some testing?  Then merge
> maybe for 2.6.17?  Posted last time in december, with nobody complaining
> any more about the most recent version.  The patch is almost unmodified
> since, I've only had to add a small chunk due to the mutex merge.
> Description is below, the patch (against -rc1-git4 snapshot) is attached.

FYI, I have this being used in Ubuntu's kernel right now. It's pretty
stable. I have it implemented for x86_64 aswell. I can send you that
patch when I get a chance to pull it from the repo cleanly. I did enable
a kconfig option and command line option so it can be enabled/disabled
by default and also at boot.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

