Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUBAQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUBAQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:59:22 -0500
Received: from quechua.inka.de ([193.197.184.2]:4306 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265370AbUBAQ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:59:21 -0500
Subject: Re: 2.6 input drivers FAQ
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2ekte94kt.fsf@p4.localdomain>
References: <20040201100644.GA2201@ucw.cz>
	 <pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
	 <m2ekte94kt.fsf@p4.localdomain>
Content-Type: text/plain
Message-Id: <1075654692.14253.1.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 01 Feb 2004 17:58:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 16:56, Peter Osterlund wrote:
> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
> > And what about dell latitude laptops (synaptics touchpad - works fine -
> > plus that mouse stick - no reaction at all?
> > 
> > Usualy I'm fine with the touchpad, but some people prefer to use
> > the stick or both. Any idea?
> 
> X isn't reading from /dev/input/mouse1, which is where the events for
> the stick go in your case. You need to add another InputDevice to your
> X config or use the /dev/input/mice device node.

ah, stupid me. Thanks, now it is working.

Regards, Andreas

