Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDSFb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 01:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDSFb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 01:31:59 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:6838 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262960AbUDSFb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 01:31:57 -0400
From: "Cef (LKML)" <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: ifplugd/e1000 oops
Date: Mon, 19 Apr 2004 15:32:00 +1000
User-Agent: KMail/1.6.2
References: <20040419050001.GE4288@evdebs.org>
In-Reply-To: <20040419050001.GE4288@evdebs.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191532.01938.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 03:00 pm, Adam Goode wrote:

> I'm using ifplugd to monitor the link beat and automatically bring up
> or down the network interfaces on my laptop.
>
> When I unplugged my cable today, I got an oops. When I plugged it back
> in, nothing happened. (Normally it should beep and bring the interface
> back up.) When I removed and inserted the e1000 module, I got a freeze.

I've got a report of a similar oops, also using ifplugd. User in question (on 
IRC) is complaining that this has been happening for all of 2.6, in late 2.5 
(hasn't pinpointed any specific version) and in 2.4 since about 2.4.23.

Unfortunately in his case, it dies processing interrupts, so he gets nothing 
on disk, and is reluctant to set up a serial console on his box. I've tried 
emulating it here, but as yet have had no luck in getting it to oops.

Note: He's using an Intel EEPro/100B in his box, though he has a spare 
(unused) Realtek 8029 in there as well.

BTW: Kernel & ifplugd versions might be useful.

