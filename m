Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWCWQuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWCWQuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWCWQuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:50:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750832AbWCWQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:50:00 -0500
Subject: Re: [RFCLUE2] 64 bit driver 32 bit app ioctl
From: Arjan van de Ven <arjan@infradead.org>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4422B95D.9070900@beezmo.com>
References: <4422B95D.9070900@beezmo.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 17:49:57 +0100
Message-Id: <1143132597.3147.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 07:06 -0800, William D Waddington wrote:
> Apologies for dashing this off without the proper homework.  My
> customer is out of country doing an installation, and didn't test
> this configuration first :(
> 
> Customer is running RHEL3 on a 64 bit PC.  Running the 64 bit kernel
> and my 64 bit driver.  They are calling the driver from their 32 bit
> app.  The driver supports a whole mess of ioctls.
> 
> It seems that the kernel is trapping the 32-bit ioctl call and returning
> an error to the app w/out calling the driver.  It looks like
> register_ioctl32_conversion() can convice the kernel that the driver can
> handle 32-bit calls, but it has to be called for each ioctl cmd (??)

you forgot to attach you code btw or post the url to it..


