Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVJVCI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVJVCI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 22:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVJVCI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 22:08:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26299 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932564AbVJVCI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 22:08:58 -0400
Date: Fri, 21 Oct 2005 19:08:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: damir.perisa@solnet.ch, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
 'flip'
Message-Id: <20051021190839.2f94f2a2.pj@sgi.com>
In-Reply-To: <1129572346.2424.8.camel@localhost>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<200510171229.57785.damir.perisa@solnet.ch>
	<1129572346.2424.8.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan or Andrew,

Would it be appropriate for me to send in a patch that disabled
CONFIG_SERIAL_JSM in *-mm/arch/ppc64/defconfig for the time being?

As Alan has explained, his flip buffer removal killed serial jsm
(it was already in ill health.)

I trip over it when I try to cross compile all the defconfig's.

My inclination is that it better to make an effort to keep *-mm
compiling for all defconfigs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
