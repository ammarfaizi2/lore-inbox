Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUANQvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUANQvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:51:03 -0500
Received: from adsl-ull-213-87.42-151.net24.it ([151.42.87.213]:18186 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261731AbUANQvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:51:00 -0500
Date: Wed, 14 Jan 2004 17:50:57 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Mauro Andreolini <m.andreolini@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
Message-ID: <20040114165056.GD13899@picchio.gall.it>
Mail-Followup-To: Mauro Andreolini <m.andreolini@tiscali.it>,
	linux-kernel@vger.kernel.org
References: <3FE5F1110001ED59@mail-4.tiscali.it> <20040113131806.GA343@elf.ucw.cz> <20040113212811.GA12144@gateway.milesteg.arr> <400564AD.6050407@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400564AD.6050407@tiscali.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.24-xfs-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 04:47:57PM +0100, Mauro Andreolini wrote:
> Hi Daniele,
> 
> the card does _not_ work after resume, both on 2.6.1-rc2 vanilla and 
> with Pavel's patch.
> I have to manually

This is quite strange because for me the card works on resume, I
have the driver compiled in, but that should make no difference.

Could you try to plug/unplug the cable and see if it detects media
changes ? Messages like "Media link on/off" should appear.

Also, since probably the problem is that the mac filter is not reset
correctly, could you try tcpdump and see if in promiscous mode it
receives something ?

Thanks.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

