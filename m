Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271923AbTGYEMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 00:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271924AbTGYEMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 00:12:23 -0400
Received: from www.opensource-ca.org ([168.234.203.30]:26077 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S271923AbTGYEMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 00:12:23 -0400
Date: Thu, 24 Jul 2003 22:22:35 -0600
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ihar Philips Filipau <filia@softhome.net>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Message-ID: <20030725042235.GA7777@guug.org>
References: <3038B2BC-BE10-11D7-B453-000A95A0560C@us.ibm.com> <20030724212000.GC12002@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724212000.GC12002@werewolf.able.es>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 11:20:00PM +0200, J.A. Magallon wrote:
> Or you just define must_inline, and let gcc inline the rest of 'inlines',
> based on its own rule of functions size, adjusting the parameters
> to gcc to assure (more or less) that what is inlined fits in cache of
> the processor one is building for...
> (this can be hard, help from gcc hackers will be needed...)

IMO just a CONFIG_INLINE_FUNCTIONS will work, if you
want to conserve space in detriment of speed simply
don't select this option, else you have speed but
a big kernel.

-solca

