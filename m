Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbTFSL7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbTFSL7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:59:53 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:37859 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S265780AbTFSL7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:59:52 -0400
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, davidm@hpl.hp.com,
       Riley Williams <Riley@Williams.Name>, linux-kernel@vger.kernel.org
In-Reply-To: <20030617234827.K32632@flint.arm.linux.org.uk>
References: <16110.4883.885590.597687@napali.hpl.hp.com>
	 <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
	 <16111.37901.389610.100530@napali.hpl.hp.com>
	 <20030618002146.A20956@ucw.cz>
	 <16111.38768.926655.731251@napali.hpl.hp.com>
	 <20030618004233.B21001@ucw.cz>
	 <20030617234827.K32632@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1056024808.27851.200.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Thu, 19 Jun 2003 13:13:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 23:48, Russell King wrote:
> On Wed, Jun 18, 2003 at 12:42:33AM +0200, Vojtech Pavlik wrote:
> > an arch-dependent #define is needed. I don't care about the location
> > (timex.h indeed seems inappropriate, maybe the right location is
> > pcspkr.c ...), or the name, but something needs to be done so that the
> > beeps have the same sound the same on all archs.
> 
> This may be something to aspire to, but I don't think its achievable
> given the nature of PC hardware.  Some "PC speakers" are actually
> buzzers in some cases rather than real loudspeakers which give a
> squark rather than a beep.

They're not _that_ bad. Even on most recent hardware, mp3s played
through the PC speaker are relatively recognisable :)

-- 
dwmw2

