Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTLIAbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTLIAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:31:06 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:18116 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S262131AbTLIAbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:31:03 -0500
Date: Tue, 9 Dec 2003 01:31:00 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Greg KH <greg@kroah.com>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
In-Reply-To: <20031208233428.GA31370@kroah.com>
Message-ID: <Pine.LNX.4.58.0312090128130.11775@mercury.sdinet.de>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Greg KH wrote:

> > After ignoring .devfsd we are left with 70 devices missing:
> >  - 15 floppy devices
>
> You have 15 floppy devices connected to your box?  All floppy devices
> should show up in /sys/block.

perhaps he means fd0u1440, fd0u1600 and friends

ls /dev/fd0u*|wc -l  -> 15

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
