Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUANJBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUANJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:01:51 -0500
Received: from gprs214-15.eurotel.cz ([160.218.214.15]:21632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265464AbUANJBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:01:50 -0500
Date: Wed, 14 Jan 2004 10:01:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
       cpufreq@www.linux.org.uk, linux@brodo.de, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114090138.GB260@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C080EF39F@txexmtae.amd.com> <20040114034237.GT14674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114034237.GT14674@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > >> Dave had a good idea of a minimal ACPI parser for trying to retrieve the
>  > >> table of p-states from an ACPI BIOS without needing the full AML interpreter.
>  > >> I will see if I can get that to work in powernow-k8-acpi 
>  > >  
>  > > If done properly, that parsing code could be shared by the K7 
>  > > driver too.
>  > 
>  > Agreed. Function in a header file? Don't want the drivers attempting to
>  > call each other at runtime.
> 
> Works for me, or shove it out into its own .c file, and have both drivers link against it.

Would acpi parsing be usefull for non-amd systems, too?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
