Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUCVKXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUCVKXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:23:22 -0500
Received: from gprs214-145.eurotel.cz ([160.218.214.145]:45184 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261866AbUCVKXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:23:21 -0500
Date: Mon, 22 Mar 2004 11:23:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: AC adapter status wrong after resume (swsusp, pmdsik)
Message-ID: <20040322102311.GC273@elf.ucw.cz>
References: <20040322100824.GA27330@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322100824.GA27330@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    	I think I found a problem with ACPI and disk-suspend "swsusp" option
>         of 2.6.4 kernel. 
>         
>         In a few words: when resuming the "ac adapter status" would not
>         refresh: if I suspend the laptop with the AC adapter on, then on
>         resuming ACPI -v will report AC on even if I have plugged out the
>         charger. Plugging the charger in and out will resume normal
>         behaviour. I discovered it because cpufreqd would not lower the CPU
>         clock after the resume... 

That's known, and it is issue with ACPI. ACPI list is right place to
ask about it. (But I do not think anyone is working on that :-( ).

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
