Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWAaUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWAaUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWAaUY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:24:59 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:54435 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751452AbWAaUY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:24:58 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue, 31 Jan 2006 21:24:56 +0100
Cc: linux-kernel@vger.kernel.org
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: vgacon scrolling problem [Was: Re: 2.6.16-rc1-mm4]
In-reply-to: <drln68$n82$1@sea.gmane.org>
Message-Id: <20060131202454.CDC2322AEAC@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka wrote:
>In vgacon.c, there is a stray printk("vgacon delta: %i\n", lines); which
>effectively disables the scrollback of the vga console (at least when
>not using the new soft scrollback). Removing it fixes the problem.
Then ... could you post a patch?

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
