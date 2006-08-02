Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWHBHLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWHBHLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWHBHLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:11:31 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:40080 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751298AbWHBHLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:11:30 -0400
Date: Wed, 2 Aug 2006 09:08:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
In-Reply-To: <20060802001626.GA14689@redhat.com>
Message-ID: <Pine.LNX.4.61.0608020908180.7593@yvahk01.tjqt.qr>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain>
 <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com>
 <20060801230003.GB14863@martell.zuzino.mipt.ru> <20060801231603.GA5738@redhat.com>
 <jebqr4f32m.fsf@sykes.suse.de> <20060801235109.GB12102@redhat.com>
 <20060802001626.GA14689@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 		printk(" %02x", (unsigned char)data[offset + i]);

Remove cast. (Or does it spew a warning message for you?)


Jan Engelhardt
-- 
