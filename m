Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVCXUVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVCXUVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVCXUVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:21:05 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:1355 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261500AbVCXUUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:20:45 -0500
Date: Thu, 24 Mar 2005 12:20:40 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050324202040.GC9005@hexapodia.org>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <d120d500050324111826335f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050324111826335f67@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 02:18:40PM -0500, Dmitry Torokhov wrote:
> On Thu, 24 Mar 2005 10:10:59 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> > So I added i8042.noaux to my kernel command line, rebooted, insmodded
> > intel_agp, started X, and verified no touchpad action.  Then I
> > suspended, and it worked fine.  After restart, I suspended again - also
> > fine.
> > 
> > So I think that fixed it.  But no touchpad is a bit annoying. :)
> 
> Try adding i8042.nomux instead of i8042.noaux, it should keep your
> touchpad in working condition. Please let me know if it still wiorks.

With nomux the touchpad works again, but suspend blocks in the same
place as without nomux.

(How can I verify that "nomux" was accepted?  It shows up on the "Kernel
command line" but there's no other mention of it in dmesg.)

-andy
