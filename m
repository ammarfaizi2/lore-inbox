Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVHOW1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVHOW1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVHOW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:27:06 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:19646 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S965014AbVHOW1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:27:05 -0400
Date: Tue, 16 Aug 2005 00:27:02 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Naveen Gupta <ngupta@google.com>
Cc: wim@iguana.be, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] set enable bit instead of lock bit of Watchdog Timer in Intel 6300 chipset
Message-ID: <20050815222701.GB18872@hardeman.nu>
References: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 02:21:05PM -0700, Naveen Gupta wrote:
>
>This patch sets the WDT_ENABLE bit of the Lock Register to enable the
>watchdog and WDT_LOCK bit only if nowayout is set. The old code always
>sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
>end up locking the watchdog instead of enabling it.
>
>Signed-off-by: Naveen Gupta <ngupta@google.com>

Acked-by: David Härdeman <david@2gen.com>

Thanks Naveen.

//David
