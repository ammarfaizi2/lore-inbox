Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUIYEYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUIYEYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUIYEYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:24:43 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:43682 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269227AbUIYEYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:24:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK] Changing driver core/sysfs/kobject symbol exports to GPL only
Date: Fri, 24 Sep 2004 23:24:38 -0500
User-Agent: KMail/1.6.2
Cc: Patrick Mochel <mochel@digitalimplant.org>, greg@kroah.com
References: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409242324.38923.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 September 2004 10:42 pm, Patrick Mochel wrote:
> What's life without a little controversey once in a while?
> 
> The attached patch and referenced BK tree changes all the symbol exports
> in the driver core, sysfs, and the kobject core to EXPORT_SYMBOL_GPL [1].

May I ask to keep class_simple and maybe platform_device_register_simple
available to non-GPL modules. These functions offer limited and documented
semantic and while it is impossible to build entire new subsystem around
them it will allow non-GPL stuff still be somewhat integrated - standard
hotplug mostly I think...

-- 
Dmitry
