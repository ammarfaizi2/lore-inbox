Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269191AbTCBMJH>; Sun, 2 Mar 2003 07:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269194AbTCBMJH>; Sun, 2 Mar 2003 07:09:07 -0500
Received: from [219.65.82.84] ([219.65.82.84]:4736 "HELO
	magrathea.home.amit.net") by vger.kernel.org with SMTP
	id <S269191AbTCBMJF> convert rfc822-to-8bit; Sun, 2 Mar 2003 07:09:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Amit Shah <shahamit@gmx.net>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] taskqueue to workqueue update for riscom8 driver
Date: Sun, 2 Mar 2003 17:51:01 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303021751.01224.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 March 2003 10:08, Matthew Wilcox wrote:
> No, this driver needs to be converted to the new serial core.  It's still
> using cli(), for example.

That's a different issue, isn't it? This patch was just meant to get the 
drivers in a compilable state... I'll look into the cli() issue, but I don't 
have any hardware to test...

-- 
Amit Shah
http://amitshah.nav.to/

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                -- Isaac Asimov
		

