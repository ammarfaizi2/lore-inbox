Return-Path: <linux-kernel-owner+w=401wt.eu-S964936AbXADPzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXADPzN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbXADPzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:55:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56898 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937AbXADPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:55:11 -0500
Date: Thu, 4 Jan 2007 16:48:28 +0100
From: Petr Baudis <pasky@suse.cz>
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       Thorsten Kukuk <kukuk@suse.de>, Thomas Renninger <trenn@suse.de>,
       linux-acpi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /usr/include/*/acpi.h
Message-ID: <20070104154828.GH13181@pasky.or.cz>
References: <200701031552.37919.lenb@kernel.org> <20070104104945.GA31430@suse.de> <459CDEB0.5040302@linux.intel.com> <200701041015.45525.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701041015.45525.lenb@kernel.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 04:15:45PM CET, Len Brown wrote:
> > > This header files are part of the linux kernel, and thus of course
> > > available in /usr/include/{asm,linux}.
> 
> So you pick up all of the kernel include/linux and include/asm*?
> (but exclude include/acpi/, which is as much a kernel header as the above)

Yes, we do not exclude any files from the kernel headers package, since
it is safer to have an extra file there than miss something that
something in userspace *could* need - or that is not needed now but can
silently become useful for something userspace in the future. An "all
headers part of the linux kernel" is much safer definition than "a
somewhat random selection of kernel headers".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
		-- Kurt Vonnegut, Sirens from Titan
