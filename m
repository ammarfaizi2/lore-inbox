Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVGPV3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGPV3D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGPV3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:29:03 -0400
Received: from isilmar.linta.de ([213.239.214.66]:57998 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261803AbVGPV2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:28:55 -0400
Date: Sat, 16 Jul 2005 23:28:54 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linix-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 vs. /sbin/cardmgr
Message-ID: <20050716212854.GA17338@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Bob Tracy <rct@gherkin.frus.com>, linix-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20050716163645.8FD8DDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716163645.8FD8DDBA1@gherkin.frus.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Jul 16, 2005 at 11:36:45AM -0500, Bob Tracy wrote:
> rct wrote:
> > Dominik Brodowski wrote:
> > > On Sun, Jul 10, 2005 at 03:37:22PM -0500, Bob Tracy wrote:
> > > > Dominik Brodowski wrote:
> > > > > On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> > > > > > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
> > > > > 
> > > > > Please post the output of "lspci" and "lsmod" as I'd like to know which
> > > > > kind of PCMCIA bridge is in your notebook.
> > > 
> > > OK, it's a plain TI1225. Could you try whether the bug is still existent in
> > > 2.6.13-rc3, please?
> > 
> > 2.6.13-rc3 works fine here.  The "cardmgr" process is no longer chewing
> > up lots of CPU time, and otherwise seems to be working correctly.  Thanks!
> 
> I spoke too soon :-(.  The first boot on 2.6.13-rc3 was fine.  Every
> boot since then has reflected no change relative to the 2.6.12 behavior.
> The "cardmgr" process racks up CPU time almost as fast as time
> elapses: it's at the top of the "top" list.

Can you send me a dmesg of 2.6.13-rc3, please?

Thanks,
	Dominik
