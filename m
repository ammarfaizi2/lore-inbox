Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUBEVTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUBEVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:18:59 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:26531 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266787AbUBEVQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:16:35 -0500
Date: Thu, 5 Feb 2004 22:16:33 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205211633.GH10547@stud.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040205203336.GE10547@stud.uni-erlangen.de> <20040205205421.GE11683@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205205421.GE11683@suse.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> So the drive ought to report media changed if it knowingly over wrote
> the table of contents, for instance.

I am not so sure about this. I can't find anything describing this. But
looking at SPC-2 Section 7.25 talks only about 'becoming ready and media
changed'.

> I still think this is to be expected when mucking in undefined teritory.
> Reload the media, it's not hard... Sure you can get around this with
> snooping if you really wanted to, but IMO it's wasted effort. Add -eject
> to cdrecord command line of default config, how you want so solve it is
> not my problem.

I don't understand why the Linux kernel doesn't simply invalidates the
buffers when a CDROM media is unmounted. If this would be case no such
problems would ever occur.

	Thomas
