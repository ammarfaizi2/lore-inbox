Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbULBOME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbULBOME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbULBOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:12:04 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:18404 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261636AbULBOLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:11:44 -0500
Date: Thu, 2 Dec 2004 15:11:32 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Andreas Schwab <schwab@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
Message-ID: <20041202141132.GO11992@fi.muni.cz>
References: <20041202124456.GF11992@fi.muni.cz> <200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz> <jeu0r4ajl4.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeu0r4ajl4.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
: If you want real compatibility you should use size_t, which is what 2.4 is
: effectively using.
: 
	I assume that sizeof(struct .. *) == sizeof(size_t) on i386.
COSA is an old ISA-based device (out of production now), and I don't think
it will be ever used in non-i386 machine. In fact it is the first time
someone tried to use it on 2.6 kernel (and thus I had to fix the driver :-).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
