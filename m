Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUD1L1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUD1L1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUD1L1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:27:51 -0400
Received: from [80.72.36.106] ([80.72.36.106]:50316 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264735AbUD1L1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:27:20 -0400
Date: Wed, 28 Apr 2004 13:27:13 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sf.net, speedtouch@ml.free.fr
Subject: Re: USB related oops in 2.6.6-rk2-bk3 (similar with 2.6.5)
In-Reply-To: <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0404281325250.5272@alpha.polcom.net>
References: <200403262054.56725@WOLK> <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net>
 <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anybody going to look at it? It prevents my system from shuting down.


On Tue, 27 Apr 2004, Grzegorz Kulewski wrote:

> Hi,
> 
> I experienced this oops. I have uhci-hcd and two devices. One is usb 
> camera (TC111 - probably not supported under linux?) and the 
> second is speedtouch modem. Everytime I shut down my system (Gentoo) with 
> 2.6.5 and newer I get some oops but system log is down before that and I 
> have no time to hack start scripts to stop shuting syslog. It occures when  
> removing some usb modules. So I stopped speedtouch and removed the modules 
> manually (in stop scripts order I hope). But I have not removed uhci-hcd 
> module (this module is removed in other part of stop scripts). And... 
> nothing happened. So I unplugged speedtouch and replugged it back. And I 
> immendiatelly got atached oops. (I think that I should use ksymoops, but 
> it is searching for /proc/ksyms that is not present in 2.6 and it does not 
> like /proc/kallsyms... And it produces nothing but warnings. What options 
> should I use?)
> 
> What can I do to help track the problem down?
> 
> 
> thanks in advance
> 
> Grzegorz Kulewski
> 
> 
> PS. I am subscribbed only to LKML, so CC me, please.
