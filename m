Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCUO6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCUO6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCUO6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:58:15 -0500
Received: from one.firstfloor.org ([213.235.205.2]:38836 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261819AbVCUO6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:58:12 -0500
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
From: Andi Kleen <ak@muc.de>
Date: Mon, 21 Mar 2005 15:58:10 +0100
In-Reply-To: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> (Bodo Eggert's
 message of "Sun, 20 Mar 2005 05:37:20 +0100 (CET)")
Message-ID: <m1is3l3v25.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> writes:
>
> atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
>  (I'm using a keyboard switch and a IBM PS/2 keyboard)

This one should be just taken out. It is as far as I can figure out
completely useless and happens on most machines.

-Andi

