Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbTGOTWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269616AbTGOTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:22:36 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22021 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269612AbTGOTW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:22:28 -0400
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Kristensen <michael@wtf.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030715185852.GA519@sokrates>
References: <20030715185852.GA519@sokrates>
Content-Type: text/plain
Message-Id: <1058297835.681.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 21:37:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 20:58, Michael Kristensen wrote:
> * Dave Jones <davej@codemonkey.org.uk> [2003-07-15 20:33:00]:
> >> CONFIG_INPUT=m
> > Because this is m, Kconfig is hiding CONFIG_VT from you.
> 
> When I read the help for CONFIG_VT, I was convinced that was it, but
> when I tried to enable CONFIG_VT it still didn't work. It just sounded
> so like that was it. Any other suggestions?

Try with:

CONFIG_INPUT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VGA_CONSOLE=y

