Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWAEPTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWAEPTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWAEPTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:19:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:3255 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751408AbWAEPTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:19:37 -0500
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 16:19:16 +0100
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <p73y81vxyci.fsf@verdi.suse.de> <20060105064227.GA6120@corona.suse.cz>
In-Reply-To: <20060105064227.GA6120@corona.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051619.17366.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 07:42, Vojtech Pavlik wrote:

> > I haven't checked recently if keyboard has been fixed by now.
> 
> It's not. At this moment it's impossible to remove without significant
> surgery to the driver, because it'd prevent hotplugging and many KVMs
> from working.

Sorry? You say you can't do hot plugging in the keyboard driver
without a polling timer? 

That sounds quite bogus to me. A zillion other OS do keyboards
fine without polling timers.

-Andi
