Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTJ0Hwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 02:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJ0Hwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 02:52:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9406 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261299AbTJ0Hwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 02:52:39 -0500
Date: Sun, 26 Oct 2003 23:46:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
Subject: Re: CONFIG_IP_NF_IPTABLES=m breaks 2.6 BK compile
Message-Id: <20031026234618.71cf9190.davem@redhat.com>
In-Reply-To: <20031027041039.GA42608@compsoc.man.ac.uk>
References: <20031027034214.GA26161@merlin.emma.line.org>
	<20031027041039.GA42608@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 04:10:39 +0000
John Levon <levon@movementarian.org> wrote:

> On Mon, Oct 27, 2003 at 04:42:14AM +0100, Matthias Andree wrote:
> 
> > net/built-in.o(.init.text+0x248e): In function `init':
> > : undefined reference to `ipt_register_match'
> > 
> > .config file at
> > http://mandree.home.pages.de/linux-2.6-BK-config
> 
> Please try the below. The option needs to inherit whatever iptables
> itself got set to.

Applied, thanks John.
