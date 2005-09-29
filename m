Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVI2A4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVI2A4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVI2A4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:56:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25557 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751291AbVI2A4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:56:42 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, zippel@linux-m68k.org, tim.bird@am.sony.com
In-Reply-To: <433B3A52.30803@tuxrocks.com>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
	 <433B2E62.5050201@tuxrocks.com>  <433B3A52.30803@tuxrocks.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 17:56:37 -0700
Message-Id: <1127955398.8195.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 18:50 -0600, Frank Sorenson wrote:
> Frank Sorenson wrote:
> > I get this kernel panic on boot (serial capture) with the latest
> > git tree (2.6.14-rc2++) plus this version of ktimers:
> 
> Here's a little more information.  I've narrowed the panic down to ntpd
> startup.  Without ntpd, the system seems to run okay, but panics the
> moment I startup ntpd.

Are you just testing the ktimers patch or the full set of patches Thomas
is working with (including my code)?

thanks
-john

