Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVJVGkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVJVGkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 02:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJVGkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 02:40:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751300AbVJVGkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 02:40:01 -0400
Date: Fri, 21 Oct 2005 23:39:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: alan@lxorguk.ukuu.org.uk, damir.perisa@solnet.ch,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
 'flip'
Message-Id: <20051021233915.5ff50f9f.akpm@osdl.org>
In-Reply-To: <20051021190839.2f94f2a2.pj@sgi.com>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<200510171229.57785.damir.perisa@solnet.ch>
	<1129572346.2424.8.camel@localhost>
	<20051021190839.2f94f2a2.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Alan or Andrew,
> 
> Would it be appropriate for me to send in a patch that disabled
> CONFIG_SERIAL_JSM in *-mm/arch/ppc64/defconfig for the time being?
> 

If it helps, sure.  It looks like those patches will be -mm-only for a
while yet.  I haven't actually sat down and worked out how many drivers are
still broken, nor how important they are, but the amount of breakage does
still appear to be considerable.


