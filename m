Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUI2Aw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUI2Aw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUI2Avf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:51:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268126AbUI2Auu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:50:50 -0400
Subject: Re: [BUG: 2.6.9-rc2-bk11] input completely dead in X
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927124321.GC7486@luna.mooo.com>
References: <20040926210450.GA2960@luna.mooo.com>
	 <20040926210045.GA15897@thundrix.ch>  <20040927124321.GC7486@luna.mooo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096289303.9930.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 13:48:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-27 at 13:43, Micha Feigin wrote:
> xfree 4.3 in debian unstable (I believe its somewhat modified), debian
> calls it 4.3.0.dfsg.1-7.
> 
> The bk-input patch is a bit big for me to search for the problematic
> change, but anyone has any leads I will happily poke around further.

Make sure that the Debian developers have included the
patches/configuration options so that the keyboard driver is not banging
the keyboard/mouse I/O ports directly. The input layer does not like
that, although I've yet to see a crash/hang from it.

Alan

