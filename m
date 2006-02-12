Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWBLFqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBLFqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 00:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWBLFqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 00:46:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:60383 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932214AbWBLFqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 00:46:36 -0500
Subject: Re: 2.6.16-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Rene Engelhard <rene@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <87k6c2f1x3.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <87hd7x8uxc.fsf@hardknott.home.whinlatter.ukfsn.org>
	 <43D4129C.1090205@tee.gr> <20060123225956.GD4307@rene-engelhard.de>
	 <87k6c2f1x3.fsf@hardknott.home.whinlatter.ukfsn.org>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 16:45:11 +1100
Message-Id: <1139723111.5247.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Further investigation (using netconsole) shows the breakage (in
> 2.6.16-rc1 and -rc2) is due to discovering an additional IDE
> controller (KeyLargo) before the normal (UniNorth) controller:

Some patch that went in -rc1 screwed up the existing .config's, you
probably lost CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST

Ben.


