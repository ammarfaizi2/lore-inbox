Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTB0Tlj>; Thu, 27 Feb 2003 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTB0Tlj>; Thu, 27 Feb 2003 14:41:39 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:64004 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266755AbTB0Tlh>; Thu, 27 Feb 2003 14:41:37 -0500
Date: Thu, 27 Feb 2003 14:51:35 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com,
       ak@suse.de, davem@redhat.com, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227195135.GN21100@phunnypharm.org>
References: <20030226222606.GA9144@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226222606.GA9144@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 11:26:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is next version of ioctl32 consolidation. At one point it
> compiled on x86-64 and sparc64. I'm not 100% sure it still does...
> 
> Could you try to apply it on your architecture, fix whatever breakage
> it causes, and submit patch back to me?
> 
> ia64 has very different ioctl32 emulation (and very short). What is
> going on there? Also not all architectures knew about
> register_ioctl32_translation. Ouch.

Ok, so it was simple. Do you mind a patch that applies over yours?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
