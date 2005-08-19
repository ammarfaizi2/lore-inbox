Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVHSBdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVHSBdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVHSBdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 21:33:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:28078 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750725AbVHSBdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 21:33:45 -0400
Subject: Re: 2.6.13-rc6-rt3
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508181958.j7IJwHIf011275@cichlid.com>
References: <200508181958.j7IJwHIf011275@cichlid.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 21:32:18 -0400
Message-Id: <1124415138.5186.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 12:58 -0700, Andrew Burgess wrote:

> Similar symptoms happened to me recently and it turned out I had accidently
> omitted support for my mb ide chipset (ata_piix) while shrinking my config so
> the kernel was unable to set dma mode. Took me a while to find because everything
> was working (in PIO mode) just really slowly :-)
> 

[shameless plug]

Here's a good script to really shrink your config and not lose anything.
If you have a lot of modules configured and you want to only compile
those that are used, this perl script will do the job.

-- Steve

http://www.kihontech.com/code/streamline_config.pl



