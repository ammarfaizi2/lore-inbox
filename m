Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUIVFJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUIVFJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 01:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUIVFJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 01:09:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28805 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S267872AbUIVFJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 01:09:44 -0400
Date: Wed, 22 Sep 2004 07:09:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Hans-Frieder Vogt <hfvogt@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.9-rc2-mm1] i8042 ACPI enumeration update
Message-ID: <20040922050921.GB4532@ucw.cz>
References: <200409211352.22318.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409211352.22318.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 01:52:22PM -0600, Bjorn Helgaas wrote:

> This adds a few updates:
> 
>  - Fix build on ia64 (I8042_MAP_IRQ() isn't defined at compile-time)
>  - Add FixedIO support from Hans-Frieder Vogt
>  - Add ACPI device name (e.g., "PS/2 Keyboard Controller")
>  - Fall back to default ports/IRQ if ACPI _CRS doesn't supply them
>  - Fall back to previous blind probing if ACPI is disabled
> 
> I'd appreciate any comments or feedback.  If it looks reasonable,
> please include this in the next -mm patchset.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Could you send me the complete patch (as opposed to this differential
one)? I think it's probably time to include it into the input tree as it
seems functional enough. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
