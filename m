Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTFQOf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTFQOf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:35:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10086 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264605AbTFQOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:35:25 -0400
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030615110106.GA8404@karlsbakk.net>
References: <20030615110106.GA8404@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055861357.4240.11.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 15:49:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2003-06-15 at 12:01, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I've been waiting for the official O_DIRECT on ext3 for some time now, so I
> thought perhaps it's time to get it into 2.4.22 or so. The patch I've used, is
> the one below (for 2.4.21):

This is Andrea's patch, and it has a few problems which I've been fixing
(like allowing direct IO in journaled data mode --- bad move --- and a
couple of casting errors, nothing hugely problematic.)  Please don't
apply this, I'll send updated code later today.

Cheers,
 Stephen

