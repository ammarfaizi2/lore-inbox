Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTIOSuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTIOSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:50:20 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:60178 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261231AbTIOSuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:50:18 -0400
Date: Mon, 15 Sep 2003 11:48:39 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs problem
Message-ID: <20030915184838.GA10243@net-ronin.org>
References: <20030915105729.GA8576@net-ronin.org> <20030915161157.GA18795@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915161157.GA18795@hsnr.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 06:11:57PM +0200, Juergen Quade wrote:
> Try to increase the capacities. You just need to
> edit the file
> 	/etc/texmf/texmf.cnf

Sorry, I wasn't clear.  Every time it fails to find a font, it slaps
a backslash on the beginning of it and tries again, and keeps going
until it consumes all of TeX's memory pool.  So something either in the
DocBook utilities in Debian's broken, or the DocBook-related material
in the kernel.

-- DN
Daniel
