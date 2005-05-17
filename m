Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVEQCzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVEQCzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 22:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVEQCzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 22:55:48 -0400
Received: from graphe.net ([209.204.138.32]:37394 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261302AbVEQCzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 22:55:44 -0400
Date: Mon, 16 May 2005 19:55:42 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: randy_dunlap <rdunlap@xenotime.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
In-Reply-To: <20050516194651.1debabfd.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.62.0505161954470.25647@graphe.net>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
 <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net>
 <20050516194651.1debabfd.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, randy_dunlap wrote:

> |  endmenu
> 
> How about using choice / endchoice to that an improper HZ value
> cannot be entered at all?  (instead of using range M N)

That would not allow to set the value of CONFIG_HZ to a numeric value.
I would have CONFIG_HZ_100 CONFIG_HZ_250 etc. Gets a bit complicated
to handle.

