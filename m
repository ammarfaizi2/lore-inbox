Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUHBGPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUHBGPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHBGPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:15:39 -0400
Received: from digitalimplant.org ([64.62.235.95]:10683 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266295AbUHBGPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:15:30 -0400
Date: Sun, 1 Aug 2004 23:15:18 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: do not default to platform/firmware
In-Reply-To: <20040728222445.GA18210@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net>
References: <20040728222445.GA18210@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jul 2004, Pavel Machek wrote:

> -mm swsusp now defaults to platform/firmware suspend... That's
> certainly unexpected, changes behaviour from previous version, and
> only works on one of three machines I have here. I'd like the default
> to be changed back. Please apply,

I'd rather leave it, and put pressure on the platform implementations to
be made to work. If you want to shutdown, then specify it on the command
line before you suspend (or add it to the suspend script).


	Pat
