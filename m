Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVEDNlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVEDNlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEDNlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:41:19 -0400
Received: from levante.wiggy.net ([195.85.225.139]:2176 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261824AbVEDNlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:41:17 -0400
Date: Wed, 4 May 2005 15:41:15 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: System call v.s. errno
Message-ID: <20050504134115.GB23566@wiggy.net>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Richard B. Johnson wrote:
> Does anybody know for sure if global 'errno' is supposed to
> be altered after a successful system call?

It's not. Also this is not a kernel related question: errno is managed
by libc.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
