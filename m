Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVI2ImT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVI2ImT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 04:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVI2ImT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 04:42:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:29925 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751169AbVI2ImT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 04:42:19 -0400
Subject: Re: iMac G5: experimental thermal & cpufreq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1127978432.6102.53.camel@gaston>
References: <1127978432.6102.53.camel@gaston>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 18:40:29 +1000
Message-Id: <1127983229.6102.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 17:20 +1000, Benjamin Herrenschmidt wrote:

> http://gate.crashing.org/~benh/ppc64-smu-thermal-control.diff

You may want to re-download this one if you got it already, I just fixed
a bug in the calculations of the CPU control loop. It's now getting
results much more consistant with OS X. I still have to add some
overtemp handling and I'll remove the debug stuff and work on supporting
the PowerMac9,1 desktop model.

Ben.


