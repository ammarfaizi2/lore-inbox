Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCAOdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCAOdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVCAOdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:33:35 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:37391 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261925AbVCAOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:33:16 -0500
Message-ID: <42247DD6.1060906@aitel.hist.no>
Date: Tue, 01 Mar 2005 15:36:06 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mws <mws@twisted-brains.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <200502251430.16860.mws@twisted-brains.org> <1109379043.14993.93.camel@gaston> <200503011236.58222.mws@twisted-brains.org>
In-Reply-To: <200503011236.58222.mws@twisted-brains.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mws wrote:

>hi benjamin
>
>now i had some spare time to do some investigation
>
>booting the 2.6.11-rc5 with radeonfb.default_dynclk=0 or with -1
>brings up a framebuffer console. everything is fine.
>starting xorg-x11 with Ati binary only drivers just brings up a black screen
>without a mouse cursor and freezes the hole machine. even network ect. 
>is no more reachable from outside the machine. worst thing out of that
>a tail on the log files (on another machine) does immediately stop - also no 
>output is written to syslog :/
>
>next scenario - test 2.6.11-rc5 with radeonfb.default_dynclock=0 and -1
>starting xorg-x11 with Xorg Radeon driver. 
>a grey screen comes up - mouse cursor is visible and also able to move for
>5 - 8 seconds after screen display - then freezes the whole machine again.
>  
>
Did you try without dri? (Comment out dri in the X config file)
I use a radeon 7000 VE at work, where X will hang after a few
seconds if dri is enabled in X.  Disable dri, and it is
rock solid. xfree or x.org makes no difference here.

Helge Hafting

