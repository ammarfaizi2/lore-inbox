Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUIGQtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUIGQtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIGQrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:47:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19109 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268116AbUIGOiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:38:10 -0400
Subject: Re: Possible network issue in 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joris Neujens <joris@discosmash.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
References: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094564155.9152.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 14:35:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 14:55, Joris Neujens wrote:
> We have ruled out the following:
> Network source is slow (we were testing with the same FTP server all the
> time, from which we normally download at 10MB/sec)
> We tested with 3 different systems and network cards, and they all have
> the same problem, and only with kernel 2.6.8
> 
> any thoughts?

See the list archive, or the lwn article on broken routers mangling TCP
window size negotiation. The lwn article has a nice discussion as well
as workarounds if you need them.

