Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTA2H1R>; Wed, 29 Jan 2003 02:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTA2H1R>; Wed, 29 Jan 2003 02:27:17 -0500
Received: from mail.erunway.com ([12.40.51.200]:24071 "EHLO
	mailserver.virtusa.com") by vger.kernel.org with ESMTP
	id <S265008AbTA2H1Q>; Wed, 29 Jan 2003 02:27:16 -0500
Date: Wed, 29 Jan 2003 13:36:29 +0600
From: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129073629.GA26091@aratnaweera.virtusa.com>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129053159.GA5999@platan.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 06:31:59AM +0100, Petr Vandrovec wrote:
> 
> Though I'm not sure why you just do not upgrade to 2.4.21-pre4.

-pre3 and -pre4 don't build matroxfb_g450 and matroxfb_crtc2 as modules.
I have FB_MATROX_G450 set to "m", so these modules don't get added to
obj-m.  The "ifeq"s in the Makefile now check only for the value "y" of
this symbol, not for "m".

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.20)

Tis man's perdition to be safe, when for the truth he ought to die.

