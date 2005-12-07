Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbVLGSjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbVLGSjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbVLGSjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:39:42 -0500
Received: from xenotime.net ([66.160.160.81]:32980 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751730AbVLGSjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:39:41 -0500
Date: Wed, 7 Dec 2005 10:39:36 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
In-Reply-To: <d120d5000512071011s2e2acf14u1532e47d0f24292e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0512071038170.17648@shark.he.net>
References: <20051205212337.74103b96.khali@linux-fr.org> 
 <20051205202707.GH15201@flint.arm.linux.org.uk>  <200512070105.40169.dtor_core@ameritech.net>
  <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
 <d120d5000512071011s2e2acf14u1532e47d0f24292e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Dmitry Torokhov wrote:

> Btw, what is the policy on placing EXPORT_SYMBOL(...). Should they all
> go together (at the top or teh bottom) or after each symbol
> definition? Right now platform.c mixes 2 styles...

Not all grouped together (option 1 above), but
yes, after each symbol definition (option 2 above)...
is the current preference AFAIK.

-- 
~Randy
