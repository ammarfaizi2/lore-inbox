Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTLDXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTLDXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:07:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45808 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263711AbTLDXHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:07:25 -0500
Subject: Re: 2.6.0-test11 brings out gettimeofday() non-monotonicity
From: john stultz <johnstul@us.ibm.com>
To: Pasi Savolainen <psavo@iki.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnbsv7ng.45b.psavo@varg.dyndns.org>
References: <slrnbsv7ng.45b.psavo@varg.dyndns.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070579214.1055.94.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Dec 2003 15:06:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 12:54, Pasi Savolainen wrote:
> I (and several others) have had some problems on dual AMD platform with
> time going backwards.

Hmmm. Just to double check, you're not running w/ the amd76x_pm module,
correct? That module has known issues regarding time. 

> The 2.6.0-test11 -kernel seems to bring it forth very well. I can
> trigger this behaviour _almost_ every time, simply by running 'updatedb'.

Can you send any more info about the hardware? dmesg and .config as
well, please. 


> On the other hand I recently heard from a developer that monotonic_clock
> gave in some cases values of about 0xffffffff00000756, which to me looks
> like a botched 64bit math. This was happening on UP, AMD board.

I'd very much like to hear more details about this one. What was the
test case, etc?

thanks
-john

