Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVKLF31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVKLF31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKLF31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:29:27 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:32680 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932117AbVKLF30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:29:26 -0500
Date: Fri, 11 Nov 2005 22:29:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org, jonathan@buzzard.org.uk,
       tlinux-users@linux.toshiba-dme.co.jp, Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC: 2.6 patch] remove ISA legacy functions
Message-ID: <20051112052918.GG1658@parisc-linux.org>
References: <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111202005.GQ5376@stusta.de> <20051111203601.GR5376@stusta.de> <20051112045216.GY5376@stusta.de> <437578CD.1080501@pobox.com> <20051112051102.GF1658@parisc-linux.org> <43757D5C.8030308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43757D5C.8030308@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 12:27:56AM -0500, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >On Sat, Nov 12, 2005 at 12:08:29AM -0500, Jeff Garzik wrote:
> >
> >>it's not valid to mark working drivers broken, IMO.
> >>
> >>Mark them x86-only, perhaps.
> >
> >
> >hp100 works fine on parisc.
> 
> Certainly.  The point was, don't mark them broken, limit them to the 
> arches where they work.

I think they work fine everywhere.  Adrian wants to remove the API they
use.

I think this is a bad idea.  The drivers should be converted.
