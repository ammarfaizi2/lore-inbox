Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWBCSer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWBCSer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWBCSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:34:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31127 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030192AbWBCSeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:34:46 -0500
Subject: Re: WLAN drivers
From: Lee Revell <rlrevell@joe-job.com>
To: sclark46@earthlink.net
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Panagiotis Issaris <takis.issaris@uhasselt.be>,
       linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
In-Reply-To: <43E39E77.90403@earthlink.net>
References: <1138969138.8434.26.camel@localhost.localdomain>
	 <200602031235.31098.s0348365@sms.ed.ac.uk>
	 <1138990013.15691.272.camel@mindpipe>  <43E39E77.90403@earthlink.net>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 13:33:56 -0500
Message-Id: <1138991637.15691.283.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 13:18 -0500, Stephen Clark wrote:
> The module includes a binary hal module 
> that keeps the
> card from being abused - programmed out of FCC specs. Why is so 
> different from a card that
> has to have firmware loaded on it that in essence does the same thing
> - 
> prevents the driver
> writer from programming the card out of FCC specs. 

Big difference - firmware runs on the device, on the other side of a
bus, while a binary driver runs in the same CPU in kernel context.

I don't buy the FCC argument - after all there are completely open
drivers for other chipsets and I don't recall the FCC coming after the
distributors.

Lee

