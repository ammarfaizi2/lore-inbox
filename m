Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWEVToG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWEVToG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEVToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:44:06 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52985 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751159AbWEVToE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:44:04 -0400
From: Junio C Hamano <junkio@cox.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: APIC error on CPUx
References: <44716A5F.3070208@vdsoft.org> <p73k68e71kd.fsf@verdi.suse.de>
	<4471A777.2020404@vdsoft.org> <200605221403.16464.ak@suse.de>
	<4471AC63.8060406@vdsoft.org>
cc: Vladimir Dvorak <dvorakv@vdsoft.org>, linux-kernel@vger.kernel.org
Date: Mon, 22 May 2006 12:44:02 -0700
In-Reply-To: <4471AC63.8060406@vdsoft.org> (Vladimir Dvorak's message of "Mon,
	22 May 2006 14:19:47 +0200")
Message-ID: <7virnxalq5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Dvorak <dvorakv@vdsoft.org> writes:

>>>>>GNU/Linux
>>>>>
>>>>>Hardware:
>>>>>Intel SR1200
>>>>>
>>>>If it's an <=P3 class machine: most likely you have noise on the APIC bus.
>>>>
>>>>-Andi
>>>>
>>>Yes, you are right :
>>>
>>>cat /proc/cpuinfo
>>>...
>>>model name      : Intel(R) Pentium(R) III CPU family      1133MHz
>>>...
>>>
>>>"Noise on APIC bus" means - " a lot of interrupts from devices" ?
>>
>>Usually a crappy/broken/misdesigned motherboard.
>>
>>-Andi

I say a similar error message upon boot:

        APIC error on CPU0: 00(40)
        APIC error on CPU0: 40(40)

I run i386 kernel (Debian/etch) on Turion64 MT-30; it is an
Averatec 2155 notebook (aka MSI 1013).

