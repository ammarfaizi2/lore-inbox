Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbVIIClr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbVIIClr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbVIIClr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:41:47 -0400
Received: from orb.pobox.com ([207.8.226.5]:15521 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S965242AbVIIClq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:41:46 -0400
Message-ID: <4320F661.2010706@rtr.ca>
Date: Thu, 08 Sep 2005 22:41:37 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.13
References: <20050908235024.GA8159@kroah.com>
In-Reply-To: <20050908235024.GA8159@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is someone actively working on USB Suspend/Resume support yet?

I ask because this is becoming more and more important as people
shift more to portable notebook computers with Linux.

Enabling CONFIG_USB_SUSPEND is currently a surefire way to
guarantee crashing my own notebook on suspend/resume,
whereas it *usually* (but not always) survives when that
config option is left unset.

Nothing complicated in the configuration -- just a USB mouse,
but that's enough to nuke it.

Anyone looking at that stuff right now?
