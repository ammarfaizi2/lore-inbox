Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVLKSWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVLKSWK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVLKSWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:22:10 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:28296 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750771AbVLKSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:22:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.15-rc5-mm2: evdev problem
Date: Sun, 11 Dec 2005 13:22:05 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051211041308.7bb19454.akpm@osdl.org> <200512111647.31202.rjw@sisk.pl> <200512111702.08556.rjw@sisk.pl>
In-Reply-To: <200512111702.08556.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111322.06179.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 11:02, Rafael J. Wysocki wrote:
> The evdev driver is still broken due to the wrong order of arguments of
> copy_to_user() in evdev_event_to_user().
>

I added the correct version to my tree so next time Andrew pulls from -mm
it will be there.

-- 
Dmitry
