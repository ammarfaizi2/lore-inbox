Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUFOVeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUFOVeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUFOVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:34:00 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62110 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265953AbUFOVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:33:59 -0400
Date: Tue, 15 Jun 2004 22:33:30 +0100
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] Very Trivial - make "After * identify, caps:" messages line up
Message-ID: <20040615213330.GA6471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Jones <davej@codemonkey.org.uk>
References: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 11:21:44PM +0200, Jesper Juhl wrote:

 > Visually it's much easier to read/compare messages such as these
 > 
 > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
 > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
 > 
 > if the numbers line up like this
 > 
 > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
 > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000

I think it's pointless whilst the third 'after all inits' printk remains
a) unindented  and b) interrupted by other blurb, but in all honesty,
I don't think it really matters, so I won't object either way if it goes in.

		Dave

