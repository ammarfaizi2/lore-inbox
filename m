Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVAOCTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVAOCTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVAOCTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:19:00 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:55294 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262140AbVAOCSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:18:51 -0500
Date: Fri, 14 Jan 2005 18:25:40 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Han Boetes <han@mijncomputer.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050115022540.GA85319@gaz.sfgoth.com>
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org> <20050114042542.GB64314@gaz.sfgoth.com> <20050114103051.GJ14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114103051.GJ14127@boetes.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 14 Jan 2005 18:25:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last nitpicks, I swear:

Han Boetes wrote:
> +    panic("propolice detects %x at function %s.\n", damaged, func);

You don't need the "\n" at the end - panic() already includes a newline
Most panic() messages don't seem to have punctuation either so you can
probably lose the "." too.

Also it's nice to use "0x%X" to print hex numbers so they don't ever
get misinterpreted as decimals.

-Mitch
