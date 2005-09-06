Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVIFMkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVIFMkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVIFMkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:40:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:59791 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964821AbVIFMkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:40:36 -0400
Subject: Re: [-mm patch 3/5] SharpSL: Abstract c7x0 specifics from Corgi
	Touchscreen driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1126007630.8338.128.camel@localhost.localdomain>
References: <1126007630.8338.128.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 13:40:25 +0100
Message-Id: <1126010426.8338.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 12:53 +0100, Richard Purdie wrote:
> Separate out the Sharp Zaurus c7x0 series specific code from the Corgi
> Touchscreen driver. Use the new functions in corgi_lcd.c via sharpsl.h
> for hsync handling and pass the IRQ as a platform device resource. Move
> a function prototype into the w100fb header file where it belongs.
> 
> This enables the driver to be used by the Zaurus cxx00 series.
> 
> Index: linux-2.6.12/drivers/input/touchscreen/corgi_ts.c
> ===================================================================

I've updated Andrew with versions of patches 3 and 5 with correct
Signed-Off-by: lines.

Richard

