Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVF1WMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVF1WMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVF1WKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:10:32 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:38222 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261491AbVF1WIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:08:48 -0400
Message-ID: <42C1CA69.7060901@tls.msk.ru>
Date: Wed, 29 Jun 2005 02:08:41 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Olaf Hering <olh@suse.de>, Greg KH <greg@kroah.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com> <20050628074145.GC3577@kroah.com> <20050628195633.GA26131@smtp.west.cox.net> <20050628210804.GA26713@suse.de> <20050628212518.GA26772@smtp.west.cox.net>
In-Reply-To: <20050628212518.GA26772@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Tue, Jun 28, 2005 at 11:08:04PM +0200, Olaf Hering wrote:
[]
>>>Er, don't you need /dev/console for console output to happen? (And that
>>>it's a good idea to have /dev/null around too).  Or has that changed?
>>
>>scripts/gen_initramfs_list.sh creates that for every kernel.
> 
> I get "Warning: unable to open initial console", so on post 2.6.12 (but
> now stale) git.  Does userspace need to be doing something as well?

Are you using initramfs (cpio archive of the root fs)?
Or "ol'good" initrd (cramfs, romfs, whatever)?

/mjt
