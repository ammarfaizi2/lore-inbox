Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUAOCiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUAOCiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:38:50 -0500
Received: from codepoet.org ([166.70.99.138]:14497 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S266338AbUAOCik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:38:40 -0500
Date: Wed, 14 Jan 2004 19:38:39 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       mplayer@jburgess.uklinux.net
Subject: Re: Serial ATA (SATA) for Linux status report
Message-ID: <20040115023839.GA2509@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Courtier-Dutton <James@superbug.demon.co.uk>,
	Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	mplayer@jburgess.uklinux.net
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org> <4005D141.7050408@superbug.demon.co.uk> <4005E1D4.6040807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005E1D4.6040807@pobox.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 14, 2004 at 07:41:56PM -0500, Jeff Garzik wrote:
> 
> I'm pretty sure the "excessive interrupts" issue was successfully 
> tracked down by Jon Burgess (thanks!).  He found this post describing an 
> ICH5 hardware issue,
> http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
> 
> and he also submitted the attached patch.
> 
> I've been meaning to rewrite his patch to isolate it more to ata_piix, 
> but in the meantime maybe folks could test this?

Tried it on top of 2.4.25-pre4-libata1.  I set the BIOS on my
Asus P4P800 to Enhanced mode, and the kernel locked solid during
boot while trying to clean /tmp....  Setting the BIOS back to
Compatible mode allows my system to boot.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
