Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269674AbUISHHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269674AbUISHHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269679AbUISHHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 03:07:31 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:63159 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269674AbUISHHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 03:07:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
Date: Sun, 19 Sep 2004 02:07:27 -0500
User-Agent: KMail/1.6.2
Cc: mike cox <mikecoxlinux@yahoo.com>
References: <20040919032613.96799.qmail@web52805.mail.yahoo.com> <200409182243.37138.dtor_core@ameritech.net>
In-Reply-To: <200409182243.37138.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409190207.27604.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 10:43 pm, Dmitry Torokhov wrote:
> I will try Google for them later. They are pretty new, SuSE 8.2 would
> not have them. 

Ok, here is what I found:

The patch for hid-input to convert tilt events to HWHEEL:

http://www.t12.jp/~ryuta/misclab/debian/release/hidinput-tiltwheel-quirk-for-linux-2.6.7.patch

I am not sure who the author is as I do not know Japanese.

The patches for XFree86/XOrg allowing to get data from /dev/input/eventX
can be extracted from the floowing:

http://cudlug.cudenver.edu/gentoo/distfiles/xorg-x11-6.8.0-patches-0.2.tar.bz2

Look for patches 9000, 9001 and 9002. As far as I can see it will allow using
wheel to do horizontal scrolling as well.

-- 
Dmitry
