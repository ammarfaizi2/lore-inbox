Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311228AbSCLPJg>; Tue, 12 Mar 2002 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311229AbSCLPJQ>; Tue, 12 Mar 2002 10:09:16 -0500
Received: from p508879CE.dip.t-dialin.net ([80.136.121.206]:28545 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S311228AbSCLPJM>; Tue, 12 Mar 2002 10:09:12 -0500
Date: Tue, 12 Mar 2002 16:08:58 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Message-ID: <20020312150858.GB1108@darkside.ddts.net>
In-Reply-To: <20020310180526.GA1135@darkside.ddts.net> <20020311203438.GD332@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311203438.GD332@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 09:34:39PM +0100, Pavel Machek wrote:
> I guess this needs to be runtime-configurable at least. It is probably
> bug. Introducing the config option is not right fix.

Yes, you are right.
But as I told: It was the least invasive method for me.

Applying it as a config option, would include adding a MODULE_PARM
section, which doesn't exist yet (not for me, I have ACPI compiled
into the kernel, but to keep it consistent even if compiled as
module). I'm not *that* proof with linux kernel source to guarantee
side-effect-freeness and so on.

This part I'd like to leave for developers knowing better, what
they're doing :)

However, if someone of the ACPI developers or someone of the
patch-acceptors (:)) tells me 'do it, we'll patch it in', I'll do
it.
If it has no chance to get in, I wont do it - for me myself, my
patch is quite enough :)


thanks for your response & regards,
   Mario
-- 
Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>

"Why are we hiding from the police, daddy?"      | J. E. Guenther
"Because we use SuSE son, they use SYSVR4."      | de.alt.sysadmin.recovery
