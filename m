Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVLOIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVLOIhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVLOIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:37:15 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:30237 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1161079AbVLOIhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:37:13 -0500
Date: Thu, 15 Dec 2005 09:37:11 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       stelian@popies.net, kernel-stuff@comcast.net
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Message-ID: <20051215083711.GA29034@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch> <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com> <20051214233108.GA20127@hansmi.ch> <200512142243.28390.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512142243.28390.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 10:43:27PM -0500, Dmitry Torokhov wrote:
> The adjusted patch is below. I am still not sure if this really should be
> in mainline. Was it ever used?

That patch looks fine for me.

I would like to see it in mainline because it makes debugging and
figuring out new protocols much easier. For example, Apple changed the
protocol with the latest PowerBooks (see the other patch for that). Why
should everyone willing to implement a new protocol rewrite this code?
