Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUAZIBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUAZIBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:01:35 -0500
Received: from scrat.hensema.net ([62.212.82.150]:27372 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S262052AbUAZIBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:01:34 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: NTP problems
Date: Mon, 26 Jan 2004 08:01:32 +0000 (UTC)
Message-ID: <slrnc19iar.9d.erik@dexter.hensema.net>
References: <DC23FC33129BF1459F3105CC68E8581C5C6C9B@nbexmb01.aliant.icn>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaw, Marco (Marco.Shaw@aliant.ca) wrote:
> I've not been able to get NTP working on some of my RH7.2 and RHAS2.1 systems.
> 
> Absolutely no TCP or UDP traffic shows in a tcpdump.  The
> command ntpdate gives me this and nothing more:
> 
> 15 Jan 10:06:59 ntpdate[22868]: poll(): nfound = 0, error: Success

Is this on a 2.6 kernel? I have similar problems between two 2.6
machines, but haven't investigated it much yet.

Both systems work well as a client. My home server running 2.6 is
NTP server to the rest of the network at home. A 2.4 machine can
sync its time, but a 2.6 machine can't. The 2.6 client can sync
to the public ntp servers on the internet.

(this is all IIRC)
-- 
Erik Hensema <erik@hensema.net>
