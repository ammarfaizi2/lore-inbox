Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTFQAjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTFQAjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:39:12 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:47242 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264490AbTFQAjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:39:03 -0400
Date: Tue, 17 Jun 2003 01:52:55 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: FRAMEBUFFER (and console)
Message-Id: <20030617015255.3016cb99.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there any way to give the console a kick in the pants?

My framebuffer (and therefore system console, by definition) come up
rather late.

It seems the console doesnt care to check for drivers comming up after a
certain time, and thus I get no output despite the driver working.

I'd like to do something like console_rescan_my_damn_device() if
possible :-)

My only option right now appears to be to set up a dummy framebuffer
prior to real one starting up.

TIA.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
