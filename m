Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUBISG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbUBISG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:06:56 -0500
Received: from ns.suse.de ([195.135.220.2]:1176 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265332AbUBISGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:06:53 -0500
Date: Mon, 9 Feb 2004 19:06:51 +0100
From: Olaf Hering <olh@suse.de>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209180651.GA15842@suse.de>
References: <c07c67$vrs$1@terminus.zytor.com> <c07i5r$ctq$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c07i5r$ctq$1@news.cistron.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 09, Miquel van Smoorenburg wrote:

> In article <c07c67$vrs$1@terminus.zytor.com>,
> H. Peter Anvin <hpa@zytor.com> wrote:
> >Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
> >thinking of restructuring the pty system slightly to make it more
> >dynamic and to make use of the new larger dev_t, and I'd like to get
> >rid of the BSD ptys as part of the same patch.
> 
> bootlogd(8) which is used by Debian and Suse is started as the
> first thing at boottime. It needs a pty, and tries to use /dev/pts
> if it's there but falls back to BSD style pty's if /dev/pts isn't
> mounted - which will be the case 99% of the time.

mounting proc and dev/pts is the first thing our boot script does, since
a very long time. So it will not break anything.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
