Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUGXJnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUGXJnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 05:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUGXJnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 05:43:51 -0400
Received: from levante.wiggy.net ([195.85.225.139]:9364 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268405AbUGXJnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 05:43:50 -0400
Date: Sat, 24 Jul 2004 11:43:49 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724094349.GB15995@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4956.1090644161@ocs3.ocs.com.au> <1090645238.2296.37.camel@localhost> <20040724011129.54971669.akpm@osdl.org> <1090647444.2296.54.camel@localhost> <1090648973.2296.68.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090648973.2296.68.camel@localhost>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the current netlink messages are structs with basic data with a
variable list of attributes. This is easy to parse and all current
netlink tools support uniformly. Is it intentional that you are now
switching to text data that needs to be parsed? Your patch seems
to have RFC822-style headers that would work perfectly as standard
netlink attributes to a message.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
