Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWGMSdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWGMSdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWGMSdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:33:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:64391 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030280AbWGMSdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:33:41 -0400
Date: Thu, 13 Jul 2006 20:33:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] correct oldconfig for unset choice options
Message-ID: <20060713183342.GB32366@mars.ravnborg.org>
References: <Pine.LNX.4.64.0607131315230.12900@scrub.home> <20060713141036.GA24611@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713141036.GA24611@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 03:10:36PM +0100, Ralf Baechle wrote:
> On Thu, Jul 13, 2006 at 01:22:38PM +0200, Roman Zippel wrote:
> 
> > oldconfig currently ignores unset choice options and doesn't ask for them.
> > Correct the SYMBOL_DEF_USER flag of the choice symbol to be only set if 
> > it's set for all values.
> > 
> > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> Thanks, this patch solves my problem.
Added to the kbuild.git tree - thanks.

	Sam
