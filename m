Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUGDMei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUGDMei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUGDMei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:34:38 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:20900 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265654AbUGDMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:34:37 -0400
Date: Sun, 4 Jul 2004 05:34:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ikke <ikke.lkml@gmail.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       ap@solarrain.com
Subject: Re: 4K vs 8K stacks- Which to use?
Message-ID: <20040704123431.GA23204@taniwha.stupidest.org>
References: <Pine.LNX.4.60.0407030649120.13543@p500> <297f4e0104070403553efe6821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297f4e0104070403553efe6821@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 12:55:07PM +0200, Ikke wrote:

> I got a P2 here, and got some problems that *could* be
> related to 4k stacks.  I'm running 2.6.7-redeeman3 now
> (i.e. 2.6.7-mm3+reiser4+nick's sheduler).  If I configure
> it using 4k stacks and APM as module (not loaded) I get
> crashes (Page Faults I think). Same configuration, but 4k
> stacks disabled and APM module disabled, runs stable.

Try turning on the stack overflow checking and see what that
spits out.



  --cw
