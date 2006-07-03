Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWGCVyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWGCVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGCVyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:54:15 -0400
Received: from gw.goop.org ([64.81.55.164]:50099 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751094AbWGCVyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:54:14 -0400
Message-ID: <44A9920F.5030109@goop.org>
Date: Mon, 03 Jul 2006 14:54:23 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
References: <44A2B9AF.50803@goop.org> <20060628212616.GB30373@elf.ucw.cz> <44A2FA20.3020809@goop.org> <20060703213353.GC1674@elf.ucw.cz>
In-Reply-To: <20060703213353.GC1674@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> So... does signal_wake_up(p, 1) fix it?
>   

I'll try it out.

> I'm afraid there may be more problems lurking in the refrigerator.
>
> (If this is going to take more than few mail iterations... perhaps you
> should start bug at bugzilla.kernel.org?)
>   
http://bugzilla.kernel.org/show_bug.cgi?id=6787

    J
