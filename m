Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUETSQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUETSQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 14:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbUETSQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 14:16:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63721 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265213AbUETSQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 14:16:37 -0400
Subject: Re: apm standby on thinkpad
From: john stultz <johnstul@us.ibm.com>
To: Alexander Mirgorodskiy <mirg@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40AB65B3.2070102@cs.wisc.edu>
References: <40AB65B3.2070102@cs.wisc.edu>
Content-Type: text/plain
Message-Id: <1085076978.3121.12.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 20 May 2004 11:16:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 06:48, Alexander Mirgorodskiy wrote:
> Folks,
> 
> I ran into a problem with APM on a Thinkpad T41: the system cannot
> properly resume after a standby. The backlight turns on, but the
> screen remains blank. This happens on keypress (fn-f3) and
> idle-time-induced standbys. However, resume after "apm -S" works just
> fine.
> 
> I inserted some trace statements into the apm kernel driver and found
> that it does not seem to receive standby and resume notifications from
> BIOS if standby is initiated through fn-f3. At the same time, it does
> receive the notification on a resume from "apm -S".
> 
> P.S: I see this on a RedHat 9 system with the 2.4.20 kernel. For a
> bunch of reasons, I cannot upgrade to anything else in the short
> term. (I did try 2.4.26, but it behaved even worse -- didn't wake up
> at all, even if standby was entered with "apm -S")

Just for a datapoint, I cannot reproduce the issue using 2.6.6 on a T40
installed with Fedora Core 1.
-john

