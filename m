Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267530AbUG2WvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267530AbUG2WvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUG2Ws6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:48:58 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:33496 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S267511AbUG2Wox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:44:53 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc2-mm1: DVB: "errno" undefined
Date: Fri, 30 Jul 2004 00:44:13 +0200
User-Agent: KMail/1.6.2
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040729212737.GH23589@fs.tum.de>
In-Reply-To: <20040729212737.GH23589@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407300044.13738.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 July 2004 23:27, you wrote:
> I'm getting the following errors when trying to compile 2.6.8-rc2-mm1 as
> modular as possible (using gcc 2.95):
[snip]
> *** Warning: "errno" [drivers/media/dvb/frontends/tda1004x.ko] undefined!
> *** Warning: "errno" [drivers/media/dvb/frontends/sp887x.ko] undefined!
> *** Warning: "errno" [drivers/media/dvb/frontends/alps_tdlb7.ko] undefined!
[snip]

This is still not fixed because we (linuxtv.org) have not submitted the 
changes necessary following this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108344912617115&w=2

This is about firmware loading in those modules, and we are working on 
converting those modules to i2c_kernel to take advantage of firmware_class.

Could the offending modules be marked as broken or something untill 
linuxtv-dvb can test and submit the dvb frontend updates, which should be 
sometime soon, but probably not in time for 2.6.8?

Kenneth
