Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVJVJ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJVJ0e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 05:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVJVJ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 05:26:34 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6879 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751309AbVJVJ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 05:26:34 -0400
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
	'flip'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, damir.perisa@solnet.ch,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051021233915.5ff50f9f.akpm@osdl.org>
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <200510171229.57785.damir.perisa@solnet.ch>
	 <1129572346.2424.8.camel@localhost> <20051021190839.2f94f2a2.pj@sgi.com>
	 <20051021233915.5ff50f9f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Oct 2005 10:54:47 +0100
Message-Id: <1129974887.15961.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-21 at 23:39 -0700, Andrew Morton wrote:
> If it helps, sure.  It looks like those patches will be -mm-only for a
> while yet.  I haven't actually sat down and worked out how many drivers are
> still broken, nor how important they are, but the amount of breakage does
> still appear to be considerable.

The only broken driver I am aware of remaining is the jsm driver, and
possibly one or two embedded drivers that the authors simply won't fix
until it goes mainstream.

ISDN was the last big one and I sent fixes for that.

What else is broken ?

Alan

