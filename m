Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUFNEOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUFNEOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUFNEOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:14:00 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28179 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261830AbUFNEN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:13:59 -0400
Date: Mon, 14 Jun 2004 06:10:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Ryan Underwood <nemesis-lists@icequake.net>, twaugh@redhat.com
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040614041059.GA11739@alpha.home.local>
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet> <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk> <20040613220727.GB4771@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040613220727.GB4771@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Sun, Jun 13, 2004 at 07:07:27PM -0300, Marcelo Tosatti wrote:
 
> And two, do we really need to move parport_serial.c to drivers/char in v2.4 ? 

I believe that moving a file in the stable kernel is a bad thing when it
implies moving the module, especially for people in the embedded world,
because we can imagine some of them may have a particular update mechanism
or a pre-configured modules.dep or anything like that which will need to be
changed again for this update, while it seems there is no particular reason.

But if 2.6 has it in the same directory, this could be the occasion to move
it definitely.

Just my opinion anyway ;-)

Cheers,
Willy

