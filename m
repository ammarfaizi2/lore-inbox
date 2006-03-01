Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWCALH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWCALH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWCALH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:07:26 -0500
Received: from mail.suse.de ([195.135.220.2]:24791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964914AbWCALH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:07:26 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Date: Wed, 1 Mar 2006 12:07:08 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200602281905_MC3-1-B97E-7FDC@compuserve.com> <p73psl6zbwf.fsf@verdi.suse.de> <20060301025219.2034924c.akpm@osdl.org>
In-Reply-To: <20060301025219.2034924c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011207.10289.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 11:52, Andrew Morton wrote:
> 
> (Cc: fixed.  Please send me a copy of your MUA so I can ritually disembowel
> it).

Well it's an MNA really in this case - i read l-k using gated news with gnus.
 
> Well..  the patch had a flagrant won't-compile if CONFIG_X86_IO_APIC=y, so
> I'd consider it a bit green.

Ok - i guess it would be better to redo it anyways to handle the non ACPI case
too. I can do that.

-Andi
