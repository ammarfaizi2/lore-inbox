Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163323AbWLGUqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163323AbWLGUqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163325AbWLGUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:45:59 -0500
Received: from aou170.internetdsl.tpnet.pl ([83.17.128.170]:59423 "HELO
	aou170.internetdsl.tpnet.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1163323AbWLGUp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:45:59 -0500
From: Tomek Koprowski <tomek@koprowski.org>
Organization: Druciarze Galaktyki
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: RFC: PCI quirks update for 2.6.16
Date: Thu, 7 Dec 2006 21:45:56 +0100
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@stusta.de>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Daniel Drake <dsd@gentoo.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <20061207132430.GF8963@stusta.de> <20061207205420.15622d52.khali@linux-fr.org>
In-Reply-To: <20061207205420.15622d52.khali@linux-fr.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200612072145.56861.tomek@koprowski.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 of December 2006 20:54, Jean Delvare wrote:

> > Tomasz Koprowski (1):
> >       PCI: SMBus unhide on HP Compaq nx6110
>
> Bug #6944 might be related to this one, so I'd not include it in
> 2.6.16-stable.

Actually, the #6944 requires more investigation. I've noticed the 
kacpid going to 100% cpu without the unhide patch applied as well. It 
happens sometimes after dehibernation, putting the laptop to sleep
and waking it up again resolves the issue. I can't figure out why.

To be on the safe side I'd suggest dumping the patch, but I really 
don't think it should fix anything.

Tomek

-- 
[ tomek@koprowski.org http://www.koprowski.org ]
[ JabberID: tomek@abakus.kom.pl   gg#: 2348134 ]
[       Life is as bad as you make it be       ]
