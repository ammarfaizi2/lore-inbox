Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTA2FWk>; Wed, 29 Jan 2003 00:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTA2FWk>; Wed, 29 Jan 2003 00:22:40 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:48275 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S264657AbTA2FWj>; Wed, 29 Jan 2003 00:22:39 -0500
Date: Wed, 29 Jan 2003 06:31:59 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129053159.GA5999@platan.vc.cvut.cz>
References: <20030129020639.GA10213@aratnaweera.virtusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129020639.GA10213@aratnaweera.virtusa.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 08:06:39AM +0600, Anuradha Ratnaweera wrote:
> 
> I am looking for the matroxfb updates patch that went from -ac to
> 2.4.21-preX?  Can somebody give me a clue or a pointer?

Easiest is probably doing diff between 2.4.21-pre4 and 2.4.20, and
then taking only changes in include/linux/matroxfb.h,
drivers/video/matrox and drivers/video/Config.in... Though I'm
not sure why you just do not upgrade to 2.4.21-pre4.

You can find older version of these changes at 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest, but please note
that 2.4.21-pre4 is more uptodate than 2.4.x patches at the URL
above. 2.5.59 patch at URL above is uptodate, but it is not going to
the kernel, because it is incompatible with other fbdev drivers.

						Petr Vandrovec

