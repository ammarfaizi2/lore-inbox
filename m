Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTJOVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTJOVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:00:59 -0400
Received: from adsl-215-226.38-151.net24.it ([151.38.226.215]:61191 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264329AbTJOVA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:00:57 -0400
Date: Wed, 15 Oct 2003 23:00:55 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031015210054.GA1492@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015172742.GZ30375@earth.li>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 06:27:42PM +0100, Jonathan McDowell wrote:
> Just a quick note to say that 2.6.0-test7 is the first kernel I've been
> able to successfully suspend to disk with and then resume. Using
> "echo -n disk > /sys/power/state" now works just fine and I haven't
> needed to reboot my laptop (a Compaq Evo N200) since I started running
> the kernel last week. Thanks!

Same for me, using pmdisk.
Only thing is that the shell used to issue the echo -n disk > /sys/power/state
gets killed for an unhadled page request.

Good bargain for a working suspend, though ;-)
For me it is actually a feature, since I use su to issue the suspend
command, on resume I get back my user (not sudoed) shell...

Thanks, bye.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

