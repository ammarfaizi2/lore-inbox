Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTIQRfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTIQRfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 13:35:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20877 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262594AbTIQRf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 13:35:27 -0400
Subject: Re: 2.6.0-test5: Undefined reference to 'monotonic_clock'
From: john stultz <johnstul@us.ibm.com>
To: Stephen Torri <storri@sbcglobal.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1063790623.6829.7.camel@base>
References: <1063790623.6829.7.camel@base>
Content-Type: text/plain
Organization: 
Message-Id: <1063820014.26723.114.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Sep 2003 10:33:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-17 at 02:23, Stephen Torri wrote:
> I am compiling 2.6.0-test5 on a Alpha box. I grepped for the phrase
> 'monotonic_clock' because for some reason the file that was to provide
> it was missing. The machine is a Alpha EV56 EB164 type, PC164 variation
> using the 2.95.4. Here is the error message:

> /usr/src/linux-2.6.0-test5/drivers/char/hangcheck-timer.c:87: undefined
> reference to `monotonic_clock'

Yea, monotonic_clock, which the hangcheck-timer module uses is not yet
defined on all arches (only i386/x86-64 at the moment)

Patch to follow soon.

thanks
-john

