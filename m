Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTHYIJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTHYIJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:09:27 -0400
Received: from angband.namesys.com ([212.16.7.85]:4242 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261562AbTHYIJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:09:26 -0400
Date: Mon, 25 Aug 2003 12:09:24 +0400
From: Oleg Drokin <green@namesys.com>
To: dan@merillat.org
Cc: linux-kernel@vger.kernel.org, harik@chaos.ao.net
Subject: Re: Reiserfs kernel-crashing bug in 2.4.20 (and UML)
Message-ID: <20030825080924.GA31559@namesys.com>
References: <4878.24.165.250.16.1061688482.squirrel@mail.merillat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4878.24.165.250.16.1061688482.squirrel@mail.merillat.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Aug 23, 2003 at 09:28:02PM -0400, dan@merillat.org wrote:

> Let's get this out of the way first: I KNOW IT'S A HARDWARE BUG.  My
> system wrote corrupted data to the drive.  I've already recovered the
> partition but I have a dd'd copy around to figure this out.

> I'm keeping the on-disk image around for a while if anyone wants to take a
> look at it.

Can you please make a "metadata dump" out of it and send it to me?
You can do a metadata dump with "debugreiserfs -p /dev/yourblockdevice | bzip2 -9c >metadata.bz2".
Please use some recent reiserfsprogs version for that (and if you'd use not 3.6.11, tell me the
version number).

Thank you.

Bye,
    Oleg
