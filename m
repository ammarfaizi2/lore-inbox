Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUBLXCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUBLXCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:02:52 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:34189 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S266650AbUBLXCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:02:50 -0500
Date: Thu, 12 Feb 2004 16:04:56 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Message-ID: <20040212230456.GA911@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Craig Bradney <cbradney@zip.com.au>, linux-kernel@vger.kernel.org
References: <200402120122.06362.ross@datscreative.com.au> <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com> <20040212214407.GA865@tesore.local> <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com> <1076623565.16585.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076623565.16585.11.camel@athlonxp.bradney.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 11:06:05PM +0100, Craig Bradney wrote:

> so what does "My
> Shuttle AN35N nforce2 board can run vanilla kernels with the 12-5-2003
> dated bios version and not lock up." mean?
> 

vanilla kernels = 2.6.0-test11 through 2.6.3-rc2 and no patches.  APIC is on.

12-5-2003 BIOS:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107124823504332&w=2

not lock up:
I could reproduce the lockup consistantly.  With the 12-5-2003 bios, I cannot.  Two months have passed since the original report.

> Whenthis thread first(?) started way back when in Nov or Dec last year I
> was pretty happy.. no lockups until the 5th day.

The different nforce boards react differently because of different hardware an 
manufacterers.  But they all do have a common symptom.  

I don't know how to identify a fix from my bioses.  If someone has any clue, I 
will help out.

Jesse
