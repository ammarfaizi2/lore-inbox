Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbTLIIjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTLIIjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:39:14 -0500
Received: from ns1.netnea.com ([138.189.116.70]:9152 "EHLO james.netnea.com")
	by vger.kernel.org with ESMTP id S266149AbTLIIjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:39:09 -0500
Subject: Re: irda on dell notebook
From: Charles Bueche <charles@bueche.ch>
To: ralf@orle.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200312051908.29156.ralf@orle.de>
References: <200312051908.29156.ralf@orle.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1070954994.6169.1.camel@bluez.bueche.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 08:29:54 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

don't know if it would help you, but on my Dell I8600, I needed the
following adjustement to talk to my Sony Clié over IRDA :

echo 1000 > /proc/sys/net/irda/min_tx_turn_time
echo 1 > /proc/sys/net/irda/max_tx_window

I run 2.6.0-test11-gentoo-r2.

Regs,
Charles

On Fri, 2003-12-05 at 19:08, Ralf Orlowski wrote:
> Hi,
> 
> does anyone here know, how I can get the irda on my dell notebook to work on
> a plain vanilla kernel 2.4.23 version?
> 
> My irda system works fine with an SuSE-Linux kernel and it also worked with
> an older 2.4 kernel with ac-patch. But with the plain original kernel (in
> several versions) I can't get my irda to work.
> 
> Can someone give me a hint, what I'm doing wrong, that irda refuses to work
> on my system?
> 
> Bye 
> 
> Ralf
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer

