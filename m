Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSLKI5m>; Wed, 11 Dec 2002 03:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSLKI5m>; Wed, 11 Dec 2002 03:57:42 -0500
Received: from AMarseille-201-1-2-152.abo.wanadoo.fr ([193.253.217.152]:3440
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267078AbSLKI5l>; Wed, 11 Dec 2002 03:57:41 -0500
Subject: Re: xxx_check_var
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 10:08:49 +0100
Message-Id: <1039597729.538.39.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 07:32, James Simmons wrote:
> 
>  For the pmu_sleep_notifier can you pass in a specific struct fb_info or
> do you need to make a list of all of them?

So far, I need to make that list. But sooner or later, those notifiers
will go away and I'll use the PCI and/or new driver model PM features.

Ben.

