Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWAHKXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWAHKXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWAHKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:23:39 -0500
Received: from quechua.inka.de ([193.197.184.2]:20112 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1030633AbWAHKXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:23:39 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060108095741.GH7142@w.ods.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EvXi5-0000kv-00@calista.inka.de>
Date: Sun, 08 Jan 2006 11:23:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> It's rather strange that 2.6 *eats* CPU apparently doing nothing !

it eats it in high interrupt load. And it is caused by the pty-ssh-tcp
output, so most likely those are eepro100 interrupts.

Gruss
Bernd
