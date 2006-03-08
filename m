Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWCHAUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWCHAUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCHAUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:20:05 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24745 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751711AbWCHAUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:20:01 -0500
Date: Wed, 8 Mar 2006 01:15:56 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060308001556.GA9362@electric-eye.fr.zoreil.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306211745.GD15728@electric-eye.fr.zoreil.com> <20060307051152.GA1244@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307051152.GA1244@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> It seems to help.  It's hard to say for sure because I don't have a
> foolproof way to reproduce this panic.  It _usually_ occurs after
> copying a few hundred MB but there's no clear trigger.  I've now copied
> a few GB around using a kernel with your patch and it hasn't crashed.

netdev watchdog events appear in the dmesg of the patched driver.
The driver survived it. So I'd say that the patch does its job.

OTOH, if you ever saw the unpatched driver survive this event, yell now.

-- 
Ueimor
