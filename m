Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUI3QQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUI3QQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269327AbUI3QQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:16:40 -0400
Received: from [80.227.59.61] ([80.227.59.61]:3970 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S269324AbUI3QQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:16:35 -0400
Message-ID: <415C322A.6070405@0Bits.COM>
Date: Thu, 30 Sep 2004 20:19:54 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040928
X-Accept-Language: en-us, en, ar
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevin Fenzi <kevin-linux-kernel () scrye ! com> wrote:
 >
 > What do you get from:
 >
 > cat /sys/power/disk
 > ?

Do you mean /sys/power/state ? /sys/power/disk is for powering off the
disk ? Anyhow here are both of them

	~% cat /sys/power/disk
	shutdown
	~% cat /sys/power/state
	standby mem disk

Remember this worked fine in -rc2.

 > If it says "platform" you might try:
 >
 > echo "shutdown" > /sys/power/disk
 >
 > I wonder how many of Pavel's speed improvment patches went in with the
 > pmdisk/swsusp merge in rc3? I guess I can try it and see. :)

The speed improvement that made it stop working surely went in ;-)

Cheers
Mitch
