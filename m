Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272410AbTHNPW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272412AbTHNPWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:22:55 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:37829 "EHLO
	zigo.dhs.org") by vger.kernel.org with ESMTP id S272410AbTHNPWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:22:53 -0400
Date: Thu, 14 Aug 2003 17:22:27 +0200 (CEST)
From: =?ISO-8859-1?Q?Dennis_Bj=F6rklund?= <db@zigo.dhs.org>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Flameeyes <dgp85@users.sourceforge.net>, Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, <vojtech@suse.cz>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
In-Reply-To: <20030811163913.GA16568@bytesex.org>
Message-ID: <Pine.LNX.4.44.0308141719460.2191-100000@zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Gerd Knorr wrote:

> This is no reason for keeping lircd as event dispatcher, the input layer
> would do equally well (with liblirc_client picking up events from
> /dev/input/event<x> instead of lircd).

Would this allow you to have one reciever and different remote controles
(used for different programs in the end)?

You don't want both remotes map button 1 to the same BTN_1 or whatever
symbol is used.

-- 
/Dennis

