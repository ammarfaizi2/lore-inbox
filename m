Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUIWFtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUIWFtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIWFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:49:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263770AbUIWFtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:49:01 -0400
Date: Thu, 23 Sep 2004 01:48:42 -0400
From: Alan Cox <alan@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: tty ldisc work version 4
Message-ID: <20040923054842.GB30650@devserv.devel.redhat.com>
References: <20040922141821.GA27672@devserv.devel.redhat.com> <20040922172139.0d7a1dd3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922172139.0d7a1dd3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 05:21:39PM -0700, Andrew Morton wrote:
> > The big changes this time are locking/ordering rules for termios changes. As
> > well as various feature changes I've also begun commenting n_tty.c so we
> > can start tackling the ldisc internal issues.
> 
> This gives me "init_dev but no ldisc" when initscripts start playing with
> the USB keyboard.  The machine then stops.

Intriguing. Does this go way if you uncomment the lines below
"Switchg the line discipline back" in tty_io.c.

I'll stick a USB keyboard on my box later today and chase that down.

Alan

