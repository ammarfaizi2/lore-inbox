Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVBFRx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVBFRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBFRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:53:26 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:34658 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261254AbVBFRxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:53:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.de>
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Date: Sun, 6 Feb 2005 12:53:21 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, Richard Koch <n1gp@hotmail.com>,
       linux-kernel@vger.kernel.org
References: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl> <200502051800.33621.dtor_core@ameritech.net> <20050206092533.GC8775@ucw.cz>
In-Reply-To: <20050206092533.GC8775@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061253.21514.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 04:25, Vojtech Pavlik wrote:
> You're right, as usual. ;) How about this one? The spinlock also
> protects from concurrent hardware register access. I'm always surprised
> how much code the input API saves when converting a driver ...
> 

Yep, this looks much better.
 
-- 
Dmitry
