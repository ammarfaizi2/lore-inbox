Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272479AbTGZMsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272480AbTGZMsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 08:48:19 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:61841 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272479AbTGZMsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 08:48:16 -0400
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: cutting down on boot messages
References: <20030725195752.GA8107@middle.of.nowhere>
	<20030725200440.GA1686@matchmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 25 Jul 2003 23:09:50 +0200
In-Reply-To: <20030725200440.GA1686@matchmail.com>
Message-ID: <m37k66xqht.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> You'd do better to have a boot time command line option to limit printk
> messages to err, or above.  Most of the printk messages have been given a
> severity already, so this shouldn't be a problem, and it will probably
> uncover some errors in the severity of certain messages.

Right.
In fact I'd rather leave the console printing KERN_INFO and make sure
the (debug) messages are really KERN_DEBUG. This way we wouldn't have
much noise with normal boot, but we could see KERN_DEBUG when something
goes wrong (and the kernel is being told to print everything).
-- 
Krzysztof Halasa
Network Administrator
