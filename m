Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270671AbTHAVND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270831AbTHAVND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:13:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6669 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270671AbTHAVNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:13:02 -0400
Date: Fri, 1 Aug 2003 23:13:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Viaris <bmeneses_beltran@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems compiling kernel 2.5.75
Message-ID: <20030801211300.GA15146@mars.ravnborg.org>
Mail-Followup-To: Viaris <bmeneses_beltran@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <Law11-OE70LwHc9ny7B0000e8d4@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-OE70LwHc9ny7B0000e8d4@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 02:51:32PM -0600, Viaris wrote:
> Hi all, I ma compiling kernel version 2.5.75, but I have the folloienw
> error:
> 
> drivers/built-in.o(.text+0x1d41e): In function `pc_close':
> : undefined reference to `save_flags'
Try to disbale SMP (do you need it)?

	Sam
