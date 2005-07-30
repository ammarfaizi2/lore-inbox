Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVG3VGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVG3VGc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVG3VGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:06:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:13464 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262767AbVG3VG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:06:29 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: revert yenta free_irq on suspend
Date: Sat, 30 Jul 2005 23:08:22 +0200
User-Agent: KMail/1.7.2
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <200507302249.55409.rjw@sisk.pl>
In-Reply-To: <200507302249.55409.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302308.23934.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 July 2005 22.49, Rafael J. Wysocki wrote:
> On Saturday, 30 of July 2005 21:10, Hugh Dickins wrote:
> > Please revert the yenta free_irq on suspend patch (below)
> > which went into 2.6.13-rc4 after 2.6.13-rc3-git9.
> > 
> > Sorry Daniel, you may have a box on which resume doesn't work without
> > it, but on my laptop APM resume from RAM now fails to work because of
> > it - locks up solid.
> 
> Well, the patch is needed on other boxes too (eg. mine :-)) due to the recent
> changes in ACPI.
> 

well, i have been told so. but when i asked 'why?' nobody answered something
else than because of a ACPI change.

the patch already died in the git tree which is good.

rgds
-daniel
