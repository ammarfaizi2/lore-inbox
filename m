Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVI2X2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVI2X2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVI2X2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:28:06 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:42794 "EHLO
	mail21-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751367AbVI2X2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:28:04 -0400
X-BigFish: V
Message-ID: <433C7882.20000@am.sony.com>
Date: Thu, 29 Sep 2005 16:28:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc64-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iMac G5: experimental thermal & cpufreq support
References: <1127978432.6102.53.camel@gaston>
In-Reply-To: <1127978432.6102.53.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> The algorithm itself is extracted from darwin. However, it's a rather
> complex modified version of the PID algorithm, and thus it could use
> some review to make sure I got everything right.
> 

As we are already in the digital domain, I would think it would be 
more savvy to use a digital controller than try to simulate an
analog controller...  Why don't you abstract the control algorithm 
such that you can plug in others as they are developed.

-Geoff

