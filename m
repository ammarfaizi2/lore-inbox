Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282323AbRK2DNt>; Wed, 28 Nov 2001 22:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282322AbRK2DNj>; Wed, 28 Nov 2001 22:13:39 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:46348 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S282323AbRK2DN2>; Wed, 28 Nov 2001 22:13:28 -0500
Date: Wed, 28 Nov 2001 21:13:27 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre1
Message-ID: <20011128211327.A27177@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0111281340210.15491-100000@freak.distro.conectiva> <20011128185601.A784@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011128185601.A784@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Wed, Nov 28, 2001 at 06:56:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seconded.  Off by default and with appropriate security caveats in the
Configure.help section, which Robert has already mentioned.

It's pretty critical given the burgeoning amount of cryptography in
production environments where entropy from disk I/O is essentially
non-existent.  The security concerns are very valid, but many trade-offs
are worth it, IMHO.  I will most likely be dead in the water soon unless
I start using this patch in certain places.

Just my two humble cents,
-- 
Ken.
brownfld@irridia.com

On Wed, Nov 28, 2001 at 06:56:01PM -0800, Mike Fedyk wrote:
| On Wed, Nov 28, 2001 at 01:47:07PM -0200, Marcelo Tosatti wrote:
| > 
| > 
| > Ok, 2.4.17-pre1 is out. Still going to the mirrors though, so please wait
| > a while if you haven't found a copy on your local mirror. 
| > 
| > 
| > pre1:
| > 
| 
| Any chance you'll merge Robert's netdev-random uniformity cleanup patch with
| the default to "no"?
| 
| mf
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
