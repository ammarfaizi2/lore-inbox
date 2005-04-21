Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVDUTKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVDUTKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVDUTKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:10:38 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:42768 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261800AbVDUTKa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:10:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dM0svqXGE6WDhfTSWLq4UoTUMe90DDEawUtouymrJ67WXh62ZBPLOx0aILQ+kJnroq/iyGdcC9PrfyxEyU5QSuzxFctuZWuH9s9FL9dyJvi2YNteFdMICx0U47OuqRFQu1ioV2JqIITwaN8QFBsGHSVG11nPos+2J88lchlZCMw=
Message-ID: <40f323d005042112105c4ca4a2@mail.gmail.com>
Date: Thu, 21 Apr 2005 21:10:23 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.12-rc3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> ----
> Changes since 2.6.12-rc2:
> 
> Benjamin Herrenschmidt:
...
>     [PATCH] ppc32: Fix cpufreq problems

this depends on two patches in -mm:

add-suspend-method-to-cpufreq-core.patch
  Add suspend method to cpufreq core

add-suspend-method-to-cpufreq-core-warning-fix.patch
  add-suspend-method-to-cpufreq-core-warning-fix

without those patches defconfig is broken on ppc32

regards,

Benoit
