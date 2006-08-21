Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWHUGJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWHUGJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 02:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWHUGJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 02:09:13 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:45739 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964946AbWHUGJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 02:09:12 -0400
Date: Sun, 20 Aug 2006 23:09:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Nico Schottelius <nico-kernel20060817@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory bank detection available?
Message-ID: <20060821060909.GA19849@tuatara.stupidest.org>
References: <20060817144039.GD19497@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817144039.GD19497@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 04:40:39PM +0200, Nico Schottelius wrote:

> Is it possible to detect, which memory banks on the mainboard are in
> use under Linux/x86?

Usually 0x50..0x53 are the SPDs on the first four memory slots.
Sometimes it's 0x50..0x57 when you have 8-slots but not always.

You can also try dmidecode but dmi infomation tends to be pretty
debious as a whole.

