Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTLDSKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTLDSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:10:05 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:57827 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S263375AbTLDSKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:10:02 -0500
Subject: Re: lilo and system maps?
From: Andre Tomt <lkml@tomt.net>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031204175311.GF16568@rdlg.net>
References: <20031204175311.GF16568@rdlg.net>
Content-Type: text/plain
Message-Id: <1070561388.15415.233.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 19:09:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 18:53, Robert L. Harris wrote:
> I'm messing around on one of my dev machines which has 4 possible
> kernels installed.  2.4, 2.4-stable, 2.6, 2.6-stable (stable is the last
> known good kernel).  I currently have my System.map files laid out as:
> 
> /boot/System.map-2.6.0-test11-bk2
> /boot/System.map-2.6.0-test10-bk4
> etc.
^^^

> This way when I install a new kernel I can copy the System.map to
> /boot/System.map-2.6 instead of keeping up with all the version numbers?
> lilo doesn't seem to like the map= arguements.  Does the kernel need the
> System.map in a single place, can it figure out where it's at for a
> multiple config?

Just stick with the System.map-$(uname -r) variant and it will just work
automaticly. map= in lilo is not for System.map's.


