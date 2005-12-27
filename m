Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVL0BVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVL0BVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVL0BVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:21:55 -0500
Received: from smtp4.libero.it ([193.70.192.54]:8888 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id S932184AbVL0BVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:21:54 -0500
Date: Tue, 27 Dec 2005 02:22:42 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 7/7] RTC subsystem, test device/driver
Message-ID: <20051227022242.12628e66@inspiron>
In-Reply-To: <200512261845.34731.dtor_core@ameritech.net>
References: <20051226195913.6f680634@inspiron>
	<200512261845.34731.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 18:45:34 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> You should never ever statically allicate devices that can be unregistered.
> Guess what will happen if one does this:
> 
> 	rmmod rtc_test  < /sys/class/rtc/rtcX/date
> 
> where rctX is class device created by rtc-test0 or rtc-test1.

 Will fix, thanks!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

