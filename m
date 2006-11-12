Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753132AbWKLUfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbWKLUfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbWKLUfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:35:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753129AbWKLUfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:35:21 -0500
Subject: Re: [patch] floppy: suspend/resume fix
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061112113018.f95f40a6.akpm@osdl.org>
References: <200611121753.kACHrDDi004283@harpo.it.uu.se>
	 <20061112180953.GA3266@elte.hu>  <20061112113018.f95f40a6.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 21:35:09 +0100
Message-Id: <1163363709.15249.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 11:30 -0800, Andrew Morton wrote:
> On Sun, 12 Nov 2006 19:09:53 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Mikael Pettersson <mikpe@it.uu.se> wrote:
> > 
> > > Sorry, no joy. The first access post-resume still fails and generates:
> > 
> > ok, then someone who knows the floppy driver better than me should put 
> > the right stuff into the suspend/resume hooks :-)
> 
> I don't think anyone understands the floppy driver.
> 
> How about we just revert the lockdep change?

the lockdep change wasn't "just" an annotation, but an actual bugfix
though :(

but yeah arguably for a bug that isn't hit much :(

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

