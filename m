Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270477AbTGNQYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270584AbTGNQYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:24:32 -0400
Received: from hell.org.pl ([212.244.218.42]:56330 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S270477AbTGNQYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:24:31 -0400
Date: Mon, 14 Jul 2003 18:40:48 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Eric Valette <eric.valette@free.fr>
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while "Executing all Devices _STA and_INIT methods"
Message-ID: <20030714164048.GA15445@hell.org.pl>
Mail-Followup-To: Eric Valette <eric.valette@free.fr>,
	linux-kernel@vger.kernel.org, andrew.grover@intel.com,
	acpi-devel@lists.sourceforge.net
References: <3F12AF06.6080004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3F12AF06.6080004@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Eric Valette:
> I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
> fine. I tried today 2.6-pre1 with exactly the same hardware 
> configuration as the 2.4 one and the laptop does not boot. It hangs 
> while dispaying : "Executing all Devices _STA and_INIT methods" 
> allthough it has already printed several '.'

I reported the same on ACPI devel several (18?) hours ago. For now, the
solution is to compile a kernel without APIC support. No, the noapic option
doesn't help.

The problem appeared in 2.5.74, along with changes in handling a
BIOS-disabled APIC, or so I suppose.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
