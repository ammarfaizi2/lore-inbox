Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUIUUyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUIUUyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIUUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:54:33 -0400
Received: from smtp08.auna.com ([62.81.186.18]:30631 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S268057AbUIUUya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:54:30 -0400
Date: Tue, 21 Sep 2004 20:54:29 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH 2.6.9-rc2-mm1] i8042 ACPI enumeration update
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <200409211352.22318.bjorn.helgaas@hp.com>
In-Reply-To: <200409211352.22318.bjorn.helgaas@hp.com> (from
	bjorn.helgaas@hp.com on Tue Sep 21 21:52:22 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1095800069l.4348l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.21, Bjorn Helgaas wrote:
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
> 

Perhaps this cures my kbd/mouse disdetections (it fails somteimes at boot,
I suddenly find myself without mouse or keyboard. Replugging works.

But...your mailer has screwed the patch, tabs were changed to spaces...

Please, could you resend it ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm1 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


