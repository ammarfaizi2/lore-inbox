Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTEWUtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTEWUtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:49:45 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:55465 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264186AbTEWUto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:49:44 -0400
From: Brouard Nicolas <brouard@ined.fr>
Reply-To: brouard@ined.fr
To: mikpe@csd.uu.se
Subject: Re: "Latitude with broken BIOS" ?
Date: Fri, 23 May 2003 23:04:11 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200305231055.14872.brouard@ined.fr> <16077.58300.246307.48856@gargle.gargle.HOWL>
In-Reply-To: <16077.58300.246307.48856@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200305232304.15333.brouard@ined.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes acpi=off solved the APM problem.
I am able to suspend my laptop again!
In Mandrake Control Center, in the Lilo parameter options the acpi=off or 
acpi=on is prepared! There is a second option which can be set: "noapic". 
There is no other option.
But by default, it was acpi=on and apic.

Thanks  a lot!
Nicolas Brouard
Le Vendredi 23 Mai 2003 11:02, mikpe@csd.uu.se a écrit :
> Brouard Nicolas writes:
>  > I am not well aware of what APIC is but I was running Mandrake 8.2 on my
>  > Linux partition of a Dell Pentium III latitude 550 MHz and I don't
>  > remember such a dmesg message. But when I upgraded to Mandrake 9.1 here
>  > it is. The problem I have is that I can't have any suspend mode any more
>  > neither battery indicators and /etc/rc.d/init.d/apm start claims that
>  > apm is no more in the kernel. Is it linked to that APIC problem and this
>  > BIOS problem, why did it work earlier? Do you think that if I found a
>  > new bios from Dell it will help?
>
> The "$machine with broken BIOS detected, refusing to enable the local APIC"
> message only affects the local APIC and the few services using it like the
> NMI watchdog and some performance measurement/profiling tools.
> It has no impact on whether APM works or not.
>
> Possibly Mandrake 9.1 detects ACPI (not APIC) which would disable APM.
> Try booting with "noacpi" or "acpi=off" or whatever the option is called.

-- 
Nicolas Brouard

