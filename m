Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWBQW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWBQW4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWBQW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:56:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:59860 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751476AbWBQW4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:56:31 -0500
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1140053907.14831.49.camel@localhost.localdomain>
References: <43EF8388.10202@ruault.com>
	 <20060214114102.GC20975@vanheusden.com>
	 <1139934749.11659.97.camel@mindpipe>
	 <20060215150710.GN30182@vanheusden.com> <1140027592.2733.38.camel@mindpipe>
	 <1140053907.14831.49.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 17:56:27 -0500
Message-Id: <1140216987.2733.80.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 01:38 +0000, Alan Cox wrote:
> Some chips disable IRQs here and need to so that the stream of data
> doesn't stall and stuff fall apart. Touching the watchdog would be
> sensible.
> 
> Possibly the same is needed in the new libata pata bits too 

Are you saying this might hit on non-legacy, non-broken hardware?

Lee

