Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWA2VJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWA2VJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWA2VJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:09:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55958 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751106AbWA2VJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:09:35 -0500
Date: Sun, 29 Jan 2006 22:09:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129210923.GG1764@elf.ucw.cz>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128104611.GA4348@hardeman.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If an attacker has enough privileges for attacking the daemon, he should 
> >usually also have enough privileges for attacking the kernel.
> 
> Not necessarily, if you have your ssh-keys in ssh-agent, a compromise of 
> your account (forgot to lock the screen while going to the bathroom? 
> did the OOM-condition occur which killed the program which locks the
> screen? remote compromise of the system? local compromise?) means that a 
> large array of attacks are possible against the daemon.

Run your ssh-agent on root, then. That's as safe as kernel... And does
not add potential security holes into kernel :-).
								Pavel
-- 
Thanks, Sharp!
