Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVBVXGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVBVXGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVBVXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:06:52 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:34193 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261328AbVBVXGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:06:48 -0500
Date: Tue, 22 Feb 2005 15:06:34 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Malcolm Rowe <malcolm-linux@farside.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050222230634.GB16383@taniwha.stupidest.org>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.4217CBC9.000027C1@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 11:29:13PM +0000, Malcolm Rowe wrote:

> Following the discussion in [1], the attached patch creates
> /sys/class/block as a symlink to /sys/block. The patch applies to
> 2.6.11-rc4-bk7.

Shouldn't we really move /sys/block to /sys/class/block and put the
symlink from there to /sys/block with the hope of removing it one day?
