Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbUKYJAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUKYJAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUKYJAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:00:07 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:35208 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263023AbUKYJAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:00:03 -0500
X-Envelope-From: kraxel@bytesex.org
To: pawfen@wp.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
References: <1101338139.1780.9.camel@PC3.dom.pl>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 25 Nov 2004 09:49:47 +0100
In-Reply-To: <1101338139.1780.9.camel@PC3.dom.pl>
Message-ID: <87y8gq5n4k.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Fengler <pawfen@wp.pl> writes:

> Recenly, I test five big distributions with almost all kernels
> from 2.4.21 to 2.6.9 on several slow computers with many different
> (not quite new) graphics cards (most of them - nvidia: Riva TNT,
> GeForce, GeForce2 and S3Savage).

> Every time when I use 2.6.x kernel I get warnigs (in xorg.log) similar
> this:
> (WW) NV(0): Failed to set up write-combining range
> (0xe3000000,0x1000000)

Try 2.6.10-rc2 -- should be fixed there.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
