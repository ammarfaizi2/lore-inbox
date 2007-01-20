Return-Path: <linux-kernel-owner+w=401wt.eu-S965295AbXATPhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbXATPhW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbXATPhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:37:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965295AbXATPhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:37:21 -0500
X-Authenticated: #14842415
From: Alessandro Di Marco <dmr@gmx.it>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
Cc: linux-kernel@vger.kernel.org
References: <877ivkrv5s.fsf@gmx.it> <45B135B8.9000703@tmr.com>
Date: Sat, 20 Jan 2007 16:37:18 +0100
Message-ID: <878xfxaevl.fsf@gmx.it>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

   Alessandro Di Marco wrote:
   > Hi all,
   >
   > this is a new 2.6.20 module implementing a user inactivity trigger. Basically
   > it acts as an event sniffer, issuing an ACPI event when no user activity is
   > detected for more than a certain amount of time. This event can be successively
   > grabbed and managed by an user-level daemon such as acpid, blanking the screen,
   > dimming the lcd-panel light à la mac, etc...

   Any idea how much power this saves? And for the vast rest of us who do run X,
   this seems to parallel the work of a well-tuned screensaver.

This is just a notifier; to make it work as a screensaver you'll have to rely
on some external programs. Personally I use smartdimmer to dim my vaio panel.

Obviously you can keep your toaster flying, if you like, simply calling the
flying-toaster module instead of smartdimmer. Anyway I would use the latter on
battery. ;-)

Best,

-- 
"What made the deepest impression upon you?" inquired a friend one day of
Lincoln, "when you stood in the presence of the Falls of Niagara, the greatest
of natural wonders?" ---- "The thing that stuck me most forcibly when I saw the
Falls," Lincoln responded with the characteristic deliberation, "was where in
the world did all that water come from?" - Author Unknown
