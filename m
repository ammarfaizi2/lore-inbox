Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDTXmZ>; Fri, 20 Apr 2001 19:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRDTXmQ>; Fri, 20 Apr 2001 19:42:16 -0400
Received: from m125-mp1-cvx1b.col.ntl.com ([213.104.72.125]:48002 "EHLO
	[213.104.72.125]") by vger.kernel.org with ESMTP id <S132027AbRDTXmF>;
	Fri, 20 Apr 2001 19:42:05 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu>
	<m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz>
From: John Fremlin <chief@bandits.org>
Date: 21 Apr 2001 00:41:54 +0100
In-Reply-To: <20010420190128.A905@bug.ucw.cz>
Message-ID: <m2snj3xhod.fsf@bandits.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Pavel Machek <pavel@suse.cz> writes:

[...]

> > I'm wondering if that veto business is really needed. Why not reject
> > *all* APM rejectable events, and then let the userspace event handler
> > send the system to sleep or turn it off? Anybody au fait with the APM
> > spec?
> 
> My thinkpad actually started blinking with some LED when you pressed
> the button. LED went off when you rejected or when sleep was
> completed.

Does the led start blinking when the system sends an apm suspend? In
that case I don't think you'd notice the brief period between the
REJECT and the following suspend from userspace ;-)

[...]

-- 

	http://www.penguinpowered.com/~vii
