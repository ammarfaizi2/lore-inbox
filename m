Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUJZWIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUJZWIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUJZWIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:08:49 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:3812 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261503AbUJZWIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:08:49 -0400
Date: Tue, 26 Oct 2004 15:08:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Would auto setting CONFIG_RTC make sense when building SMP kernel?
Message-ID: <20041026220845.GA8116@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:13:19PM +0200, Jesper Juhl wrote:

> I've been wondering if it would make sense to auto enable CONFIG_RTC
> when CONFIG_SMP is set?

this came up in conversation elsewhere and im of the opinion we should
force CONFIG_RTC on for some platforms (maybe allow EMBEDDED to
disable this?)
