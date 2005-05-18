Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVERJ1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVERJ1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVERJ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:27:39 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:10668 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262138AbVERJ1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:27:24 -0400
Date: Wed, 18 May 2005 11:27:21 +0200
From: David Weinehall <tao@acc.umu.se>
To: Per Liden <per@fukt.bth.se>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050518092721.GT20439@khan.acc.umu.se>
Mail-Followup-To: Per Liden <per@fukt.bth.se>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509211323.GB5297@tsiryulnik>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 11:13:24PM +0200, Per Svennerbrandt wrote:

[snip]

> #!/bin/sh
> 
> for DEV in /sys/bus/{pci,usb}/devices/*; do
> 	modprobe `cat $DEV/modalias`
> done

{}-globbing isn't valid for POSIX /bin/sh, it's an extension.
Won't work with sh in busybox, posh, ash, and various other shells.

[snip]

Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
