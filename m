Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUACTJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUACTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:09:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:18498 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S263898AbUACTJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:09:03 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401031402210.24942-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0401031402210.24942-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Message-Id: <1073156858.9851.177.camel@localhost>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 20:07:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-03 at 20:03, Mark Hahn wrote:
> > Anyone else with that problem - ideas of the cause ?
> 
> the 2.6 scheduler tries to be much more adaptive.  doesn't it look like
> it's decided to make some wrong decisions wrt scheduling in your first run?

yeah, I think so... but as generating output in a shell is a very common
thing to do there should either be an option to turn that unwanted
behaviour off or to fix this issue...

Soeren

