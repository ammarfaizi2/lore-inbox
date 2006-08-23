Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWHWL7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWHWL7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHWL7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:59:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:61100 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932422AbWHWL7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:59:39 -0400
Date: Wed, 23 Aug 2006 13:57:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ray-gmail@madrabbit.org
cc: Robert Szentmihalyi <robert.szentmihalyi@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Group limit for NFS exported file systems
In-Reply-To: <2c0942db0608230435n1b680f11q3b19669f0bb62268@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608231356180.14327@yvahk01.tjqt.qr>
References: <20060823091652.235230@gmx.net> 
 <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com> 
 <20060823111119.203710@gmx.net> <2c0942db0608230435n1b680f11q3b19669f0bb62268@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Under 2.6 local group membership was expanded to 65536. NFS, however,
> is a standard separate from Linux, and it imposes a limit of 16 groups
> on the wire for the AUTH_UNIX credentials.
>
> If all your client systems are Linux, you can use the patch at:
>   http://www.frankvm.com/nfs-ngroups/
> as a work around. (Only the client systems need the patch.)

If only the client needs to be patched, non-patched and/or non-Linux 
clients and the server (linux or not) should have a problem, should they?


Jan Engelhardt
-- 
