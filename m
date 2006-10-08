Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWJHSeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWJHSeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWJHSeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:34:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45063 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750903AbWJHSeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:34:18 -0400
Date: Sun, 8 Oct 2006 18:34:06 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
Message-ID: <20061008183406.GA4496@ucw.cz>
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com> <20061008174759.GF6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008174759.GF6755@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun 08-10-06 19:47:59, Adrian Bunk wrote:
> On Wed, Oct 04, 2006 at 10:16:41PM +0200, Jesper Juhl wrote:
> > I have a strange "problem" with 2.6.18-git21 that I've never had with
> > any previous kernel. If I open up an xterm in X, su to root and
> > 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> > persists until the box actually reboots.
> 
> Pavel, is this a known issue or should Jesper bisect?

Jesper should show it is kernel problem and not userland race.

If userspace does kill -15 -1; kill -9 -1, and X fails to shut down in
time, it is userland problem ('should wait for X to shut down').

-- 
Thanks for all the (sleeping) penguins.
