Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264107AbUECWUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUECWUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUECWUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:20:19 -0400
Received: from hermes.dur.ac.uk ([129.234.4.9]:28649 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id S264088AbUECWUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:20:13 -0400
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
	_and_ boot
From: Mike Hearn <mh@codeweavers.com>
To: Paul Jackson <pj@sgi.com>
Cc: jreiser@BitWagon.com, akpm@osdl.org, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       ashok.raj@intel.com
In-Reply-To: <20040503151044.087d79ca.pj@sgi.com>
References: <20040426185633.7969ca0d.pj@sgi.com>
	 <20040501013304.32a750d3.pj@sgi.com> <4096526C.4060503@BitWagon.com>
	 <20040503140459.10b9d3eb.pj@sgi.com>
	 <1083619742.24587.3.camel@linux.littlegreen>
	 <20040503151044.087d79ca.pj@sgi.com>
Content-Type: text/plain
Organization: Codeweavers, Inc
Message-Id: <1083622837.24587.9.camel@linux.littlegreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Mon, 03 May 2004 23:20:37 +0100
Content-Transfer-Encoding: 7bit
X-DurhamAcUk-MailScanner: Found to be clean, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 15:10 -0700, Paul Jackson wrote:
> Once you've digested Andrew's query as to whether there is a simpler way
> to do this, 

I already digested it, I just don't know the answer. I'm not familiar
with this part of the kernel, nor exactly what the patch is doing - just
the broad strokes.

> and know whether it's this patch or some other that you want
> to push, 

The permissions problem is a kernel bug which should be fixed. I have no
thoughts on the other changes in the patch, I didn't ask for them and
don't really know what they do.

> then if you send me a patch, ideally including the printk's in
> fs/binfmt_elf.c that Reiser thought might facilitate debugging, then I'd
> be willing to apply the patch and try booting it on my ia64 SN2 hardware.

Thanks, but I'll leave this in Johns hands. I just wanted to let you
guys know that it's no longer a major problem for us as it was before,
so if you have higher priorities don't worry about Wine.

thanks -mike


