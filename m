Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVB1Nrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVB1Nrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVB1Nrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:47:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58244 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261604AbVB1NpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:45:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 28 Feb 2005 14:44:10 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
Message-ID: <20050228134410.GA7499@bytesex>
References: <422001CD.7020806@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422001CD.7020806@andrew.cmu.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 11:57:49PM -0500, James Bruce wrote:
> Hi I've read elsewhere that the following message:
>   "tveeprom(bttv internal): Huh, no eeprom present (err=-121)?"
> Means that a bttv card is dead.

Or i2c communication to the eeprom failed.  There used to be some -mm
kernels with experimental i2c stuff causing this ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
