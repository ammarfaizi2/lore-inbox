Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbUKDJkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUKDJkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUKDJkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:40:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22201 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262147AbUKDJkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:40:13 -0500
X-Envelope-From: kraxel@bytesex.org
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bttv winfast 2000 tuner type
References: <1099545507.24027.1.camel@vertex>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 04 Nov 2004 10:27:50 +0100
In-Reply-To: <1099545507.24027.1.camel@vertex>
Message-ID: <87r7na9d61.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> writes:

> Trivial patch that lets you configure the tuner type of your winfast
> 2000 tuner card. The default value is the previous hard coded value.

No.  Compile time options are evil.

There is a insmod option for that (tuner=<nr>) since ages because that
is a common issue with tv cards that they are shipped with different
tuners in different regions of the world and it isn't allways known
how to figure which one actually is used.

Just put "option bttv tuner=whatever" into your modprobe.conf and be
done with it.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
