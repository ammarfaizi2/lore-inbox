Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKEVOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKEVOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKEVOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:14:08 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:8352 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261210AbUKEVOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:14:06 -0500
Date: Fri, 5 Nov 2004 13:13:49 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] major devfs shrink based on tmpfs and lookup traps
Message-ID: <20041105211349.GA17340@taniwha.stupidest.org>
References: <200411061021.iA6ALa403415@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411061021.iA6ALa403415@freya.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 02:21:36AM -0800, Adam J. Richter wrote:

> This patch is a replacement implementation of devfs.  This patch
> combined the tmpfs "lookup traps" patch that is required for certain
> devfs functionality are a net deletion of more than 1800 lines of
> code[1].  The code that actually remains in fs/devfs has a
> .text+.data size of under 3kB.

wow, that's pretty neat.... but isn't devfs going to be killed off
sooner or later anyhow?

