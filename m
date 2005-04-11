Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVDKKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVDKKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVDKKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:15:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:990 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261757AbVDKKO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:14:58 -0400
Date: Mon, 11 Apr 2005 12:14:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Elladan <elladan@eskimo.com>
Cc: Oliver Neukum <oliver@neukum.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050411101434.GB1353@elf.ucw.cz>
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de> <200504102203.29602.oliver@neukum.org> <20050410201455.GA21568@elf.ucw.cz> <20050411032340.GC9933@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411032340.GC9933@eskimo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Encrypting swsusp image is of course even better, because you don't
> > have to write large ammounts of zeros to your disks during resume ;-).
> 
> How does zeroing help if they steal the laptop?  The data is there, they
> can just pull the hard disk out and mirror it before they boot.
> 
> The only way to improve security here is to encrypt it.  Zeroing will
> help some if they compromise root later, but I doubt that's really worth
> it considering you're screwed after a root compromise anyway.

Yes, it helps. It also helps if they steal your laptop later. And we
are switching to encryption, anyway, because it should be faster.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
