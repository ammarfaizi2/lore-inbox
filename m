Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTIXVuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTIXVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:50:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:3759 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261626AbTIXVuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:50:51 -0400
Date: Wed, 24 Sep 2003 14:34:53 -0700
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] devio.c memleak on unexpected disconnect
Message-ID: <20030924213453.GD11234@kroah.com>
References: <20030921185922.GA1185@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921185922.GA1185@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:59:22PM +0400, Oleg Drokin wrote:
> Hello!
> 
>   There is a memleak in devio.c (User space communication with USB devices)
>   recently added, it forgets to free the buffer if device was disconnected.
> 
>   The patch is trivial, please apply.
>   Found with help of smatch.

Applied to my trees, thanks.

greg k-h
