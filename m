Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUALU7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUALU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:59:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21910 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266235AbUALU7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:59:10 -0500
Date: Mon, 22 Dec 2003 13:32:37 -0500
From: Pavel Machek <pavel@ucw.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse synchronization loss under load
Message-ID: <20031222183237.GA15844@openzaurus.ucw.cz>
References: <20031220015131.GB9834@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220015131.GB9834@vitelus.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On a Dell laptop whenever I run a program that takes the full CPU, my
> mouse pointer goes insane and thrashes my X session every few minutes.
> It seems to have a mind of its own and always be able to make it to
> the Exit item in the root menu ;). Whenever this happens, psmouse logs
> and detects the error:
> 
> psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing
> 2 bytes away.

Do you use ACPI? Using  APM made the error go away for me. 

