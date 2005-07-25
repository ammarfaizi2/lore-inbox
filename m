Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVGYE6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVGYE6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 00:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGYE6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 00:58:17 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:60343 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261557AbVGYE6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 00:58:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Sun, 24 Jul 2005 23:58:11 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>
References: <9e47339105072421095af5d37a@mail.gmail.com>
In-Reply-To: <9e47339105072421095af5d37a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507242358.12597.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 July 2005 23:09, Jon Smirl wrote:
> I just pulled from GIT to test bind/unbind. I couldn't get it to work;
> it isn't taking into account the CR on the end of the input value of
> the sysfs attribute.  This patch will fix it but I'm sure there is a
> cleaner solution.
> 

"echo -n" should take care of this problem I think.

-- 
Dmitry
