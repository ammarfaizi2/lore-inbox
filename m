Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752580AbWCQJaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbWCQJaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWCQJaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:30:10 -0500
Received: from [84.204.75.166] ([84.204.75.166]:6109 "EHLO shelob.oktetlabs.ru")
	by vger.kernel.org with ESMTP id S1752580AbWCQJaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:30:09 -0500
Message-ID: <441A819F.7040305@oktetlabs.ru>
Date: Fri, 17 Mar 2006 12:30:07 +0300
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru> <20060316175858.GA7124@kroah.com> <4419A9B8.8060102@yandex.ru> <20060316182018.GA4301@kroah.com>
In-Reply-To: <20060316182018.GA4301@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> decl_subsys() is in the sysfs.h header file, not the device.h file.
> Just stay away from anything in there if you hate the driver core so
> much :)
Ok, I see, thank you. I do not hate it, it is just not appropriate for 
me. I do not have any bus. My device is a virtual device, not a real one.

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
