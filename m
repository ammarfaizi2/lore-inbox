Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHMWrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHMWrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267621AbUHMWry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:47:54 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42714 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265489AbUHMWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:47:51 -0400
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though
	sysfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200408130911.29626.jbarnes@engr.sgi.com>
References: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
	 <200408130911.29626.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092433504.24955.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 22:45:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 17:11, Jesse Barnes wrote:
> Maybe we need a display driver class?  Could we reuse the dri drivers for that 
> purpose?

Display and VGA devices do not correlate neatly. There are non VGA
devices we treat as video, and VGA devices we don't use when using the
hardware ourselves because its switched out of the video side (eg
on the Oxygen GMX)

