Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUADXdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUADXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:33:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37129 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265799AbUADXdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:33:33 -0500
Date: Mon, 5 Jan 2004 00:33:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: szonyi calin <caszonyi@yahoo.com>
Cc: azarah@nosferatu.za.org, Con Kolivas <kernel@kolivas.org>,
       Soeren Sonnenburg <kernel@nn7.de>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104233312.GA649@alpha.home.local>
References: <1073227359.6075.284.camel@nosferatu.lan> <20040104225827.39142.qmail@web40613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104225827.39142.qmail@web40613.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 11:58:27PM +0100, szonyi calin wrote:
 
> how much free memory do you have when this happens ?
> I had 
> a similar problem. It was easily reproducive doing 
> a du -sh / and then trying to do other things.
> It didn't happend all the time but most of the time

It's not the problem here. always between 200 and 400 MB free.
BTW, the system is not swapping when this happens. The scrolling
is very smooth and relatively fast (about 100 lines/s) which is
enough to understand that X eats all the CPU scrolling one line
at a time. I have yet to understand why 'ls|cat' behaves
differently, but fortunately it works and it has already saved
me some useful time.

Cheers,
Willy

