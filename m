Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVAQWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVAQWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVAQWeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:34:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53398
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262958AbVAQWbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:31:55 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
In-Reply-To: <41EC20FB.9030506@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
	 <41E7A7A6.3060502@opersys.com>
	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>
	 <41E8358A.4030908@opersys.com>
	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>
	 <41E899AC.3070705@opersys.com>
	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>
	 <41EA0307.6020807@opersys.com>
	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>
	 <1105925842.13265.364.camel@tglx.tec.linutronix.de>
	 <41EB21C2.3020608@opersys.com>
	 <1105964417.13265.406.camel@tglx.tec.linutronix.de>
	 <41EC20FB.9030506@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 23:31:53 +0100
Message-Id: <1106001113.13265.474.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 15:32 -0500, Karim Yaghmour wrote:
> You're either on crack or I don't know how to read english. Here's what
> you said:

Maybe you should read your own comment about ad-hominem attacks earlier
in this thread and consider if it might apply to you.

I know, what I have said. I said reduce the filtering to the absolute
minimum and do the rest in userspace.

The now builtin filters are defined to fit somebodys needs or idea of
what the user should / wants to see. They will not fit everybodys
needs / ideas. So we start modifying, adding and #ifdefing kernel
filters, which is a scary vision.

Enabling and disabling events is a valid basic filter request, which
should live in the kernel. Anything else should go into userspace, IMO.

tglx


