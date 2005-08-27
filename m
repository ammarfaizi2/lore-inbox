Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVH0Ukn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVH0Ukn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVH0Ukm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 16:40:42 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:19954 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750749AbVH0Ukm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 16:40:42 -0400
Date: Sat, 27 Aug 2005 22:39:35 +0200
From: Mattia Dongili <malattia@linux.it>
To: rbrito@ime.usp.br, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Fw: Oops with 2.6.13-rc6-mm2 and USB mouse
Message-ID: <20050827203935.GJ5631@inferi.kami.home>
Mail-Followup-To: rbrito@ime.usp.br, Andrew Morton <akpm@osdl.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <20050826220618.7365e690.akpm@osdl.org> <20050827200904.GA4362@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050827200904.GA4362@ime.usp.br>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc6-mm2-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 05:09:04PM -0300, Rog???rio Brito wrote:
> Hi, Andrew.
> 
> I just tested the USB mouse with 2.6.13-rc6-mm2 and ACPI disabled
> (which, according to Linus, is one of the "usual suspects") and the
> problem still occurred.

see here
http://marc.theaimsgroup.com/?l=linux-kernel&m=112481438512222&w=2

Reverting driver-core-fix-bus_rescan_devices-race.patch and applying the
patch attached to the above message fixed the oops for me.

-- 
mattia
:wq!
