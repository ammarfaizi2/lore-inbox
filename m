Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbUBKTMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBKTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:12:08 -0500
Received: from scrat.hensema.net ([62.212.82.150]:27776 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S266118AbUBKTMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:12:06 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: reiserfs for bkbits.net?
Date: Wed, 11 Feb 2004 18:41:51 +0000 (UTC)
Message-ID: <slrnc2ktre.4t9.erik@bender.home.hensema.net>
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy (lm@bitmover.com) wrote:
> We're moving openlogging back to our offices and I'm experimenting with 
> filesystems to see what gives the best performance for BK usage.  Reiserfs
> looks pretty good and I'm wondering if anyone knows any reasons that we
> shouldn't use it for bkbits.net.  Also, would it help if the journal was
> on a different disk?  Most of the bkbits traffic is read so I doubt it.

If bitkeeper uses lots of small files and/or many files in a
directory, then reiserfs is the FS for you.

The FS has been stable for a while now and I currently don't see
any reason not to use it.

-- 
Erik Hensema <erik@hensema.net>
