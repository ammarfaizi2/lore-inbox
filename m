Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbTGDJXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTGDJXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:23:14 -0400
Received: from home.wiggy.net ([213.84.101.140]:39810 "EHLO
	tornado.home.wiggy.net") by vger.kernel.org with ESMTP
	id S265901AbTGDJXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:23:04 -0400
Date: Fri, 4 Jul 2003 11:37:32 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704093732.GA2159@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704102018.A4374@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Russell King wrote:
> Can you look in your /etc/pcmcia/config.opts and comment out/exclude
> this IO range please?

That improves things a lot. I wonder why it decided I have 2 sockets;
is that a general PCMCIA thing? This laptop only has a single PCMCIA
socket, the second slot has a smartcard reader.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

