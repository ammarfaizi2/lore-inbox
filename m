Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWJVW2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWJVW2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJVW2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:28:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750757AbWJVW2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:28:36 -0400
Subject: Re: [PATCH 1/1] Char: mxsers, correct tty driver name
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <45395451.6090302@gmail.com>
References: <3160912811766612133@muni.cz>
	 <20061019150212.6c95f6bf.akpm@osdl.org>  <45395451.6090302@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2006 23:31:29 +0100
Message-Id: <1161556289.1919.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-21 am 00:56 +0159, ysgrifennodd Jiri Slaby:
> Andrew Morton wrote:
> > On Thu, 19 Oct 2006 16:10:10 +0200
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >> Mxser tty driver name should be ttyMI, not ttyM. Correct this in both
> >> drivers (mxser, mxser_new) to avoid conflicts with isicom driver, which is
> >> ttyM.
> > 
> > Is the mxser.c part needed in mainline?
> 
> Anybody more responsible doesn't tell anything; I say "no", but it may be
> irrelevant.

I think it should go into -mm for a first cut just in case it blows
anything up. I don't think the hardware has many users any more so
hopefully it wont be disruptive.

