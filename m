Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSDSKSI>; Fri, 19 Apr 2002 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSDSKSH>; Fri, 19 Apr 2002 06:18:07 -0400
Received: from zamok.crans.org ([138.231.136.6]:2955 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S312141AbSDSKSH>;
	Fri, 19 Apr 2002 06:18:07 -0400
To: Kurt Garloff <garloff@suse.de>
Cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre6aa1 (possible all kernel after 2.4.19-pre2) athlon
 PCI workaround
In-Reply-To: <20020415174059.E2345@nbkurt.etpnet.phys.tue.nl>
	<20020416064306.91089.qmail@web10407.mail.yahoo.com>
	<20020416095703.A12012@nbkurt.etpnet.phys.tue.nl>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
Organization: Kabale Inc
Date: Fri, 19 Apr 2002 12:18:03 +0200
Message-ID: <m3zo00yotg.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO En cette matinée ensoleillée du mardi 16 avril 2002, vers 09:57,
Kurt Garloff <garloff@suse.de> disait:

>> > and claiming that not clearing bit 5 did make the
>> > problem go away.
>> > (IOW: Replace v &= 0x1f; /* clear bits 5, 6, 7 */
>> >            by v &= 0x3f; /* clear bits 6, 7 */
>> >  and see whether this helps.)

> It would be intersting to know. Maybe just clearing bits 6 and 7
> would make everybody happy? 

Another related hack is to modify latency of this northbridge to 0 and
to increase latency of "bandwidth eating" components. On
french-speaking newsgroup fr.comp.os.linux.moderated, we have several
reports that complete freeze of the system with TV cards can be
postponed (at least ; in my case, they disappeared) by this
tweak. Since, this is TV card related, I have already submitted this
to bttv maintainer (I haven't checked if latest revisions of bttv
include an option for this) but maybe decreasing to 0 the northbridge
latency could help some people too (with or without TV card).
-- 
BOFH excuse #5:
static from plastic slide rules
