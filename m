Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266464AbUBLOtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUBLOtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:49:18 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:64628 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266464AbUBLOtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:49:15 -0500
Message-ID: <402B92A4.7040703@myrealbox.com>
Date: Thu, 12 Feb 2004 06:50:12 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.6) Gecko/20040206
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: Re: [2.6.3-rc2 bk]  ieee1394 oops on bootup
References: <fa.fjveksa.v44uhu@ifi.uio.no>
In-Reply-To: <fa.fjveksa.v44uhu@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> This problem started with the bk changesets from Linus yesterday (11Feb).
> 
> I get the oops below if Firewire is compiled into the kernel or if the
> modules are loaded at bootime (I'm using hotplug+udev).  The strange
> thing is that if I load the Firewire modules by hand after bootup then
> everything is okay....

Sorry, I just discovered that this is wrong.  I can load the ieee1394
module with no errors.  It is only when I load the ohci1394 module
that the oops occurs -- even after booting.

