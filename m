Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSIBUxT>; Mon, 2 Sep 2002 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIBUxT>; Mon, 2 Sep 2002 16:53:19 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:37627
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318488AbSIBUxR>; Mon, 2 Sep 2002 16:53:17 -0400
Subject: Re: Question: Will ali apg bug be fixed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas <theunforgiven@attbi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1030995216.7931.4.camel@debian>
References: <Pine.LNX.4.44.0209021313310.3270-100000@hawkeye.luckynet.adm> 
	<1030995216.7931.4.camel@debian>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 02 Sep 2002 21:59:14 +0100
Message-Id: <1031000354.15470.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-02 at 20:33, Nicholas wrote:
> i was told that there was a bug in the ali driver where when i try to
> use direct rendoring with my radeon 7500 it brings my ENTIRE system to a
> crashing halt. (requiring a power cycle/reset) i was told that since
> most new motherboards don't come with ali that this was never going to
> be fixed. is this true? or is there a workaround of some sort? Thanks!

News to me. There were some Radeon problems with reset breaking VIA
boards but those should be fixed if you are running 2.4.19-ac and
XFree86 4.2. I don't know fi the ALi is showing the same problem.

Another cause of freezes is incorrect AGP settings. Make sure the AGP
setting in the BIOS and XF86Config match. X defaults to 1x which is ok
for most but not all chipsets as a fallback

