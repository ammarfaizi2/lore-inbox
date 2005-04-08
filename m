Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVDHWTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVDHWTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVDHWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:19:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:23726 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261166AbVDHWTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:19:17 -0400
Date: Fri, 8 Apr 2005 15:18:55 -0700
From: Greg KH <greg@kroah.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.12-rc1-mm3 Fix ver_linux script for no udev utils.
Message-ID: <20050408221855.GF3399@kroah.com>
References: <424982C0.5000708@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424982C0.5000708@mesatop.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 09:30:56AM -0700, Steven Cole wrote:
> Without the attached patch, the ver_linux script gives
> the following if udev utils are not present.
> 
> ./scripts/ver_linux: line 90: udevinfo: command not found
> 
> The patch causes ver_linux to be silent in the case of
> no udevinfo command.
> 
> Steven
> TSPA (Technical data or Software Publicly Available)

Applied, thanks.

greg k-h
