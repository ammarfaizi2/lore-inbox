Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUGLBpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUGLBpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266685AbUGLBpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:45:15 -0400
Received: from main.gmane.org ([80.91.224.249]:12200 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266684AbUGLBpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:45:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [PATCH] swsusp bootsplash support
Date: Mon, 12 Jul 2004 06:43:14 -0700
Message-ID: <m21xjh1gul.fsf@tnuctip.rychter.com>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org>
 <20040708204840.GB607@openzaurus.ucw.cz>
 <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz>
 <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz>
 <20040709115531.GA28343@redhat.com> <20040709155614.GA8426@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:R3cgoLHpbavP9eXCAPTal3QCoTM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Erik" == Erik Rigtorp <erik@rigtorp.com> writes:
 Erik> On Fri, Jul 09, 2004 at 12:55:31PM +0100, Dave Jones wrote:
 >> Personally I'd prefer the effort went into making suspend actually
 >> work on more machines rather than painting eyecandy for the minority
 >> of machines it currently works on.

 Erik> Miniority? Well both swsusp and pmdisk has worked on the majority
 Erik> of machines I've come across. From what I understand swsusp works
 Erik> on almost all x86 uniprocessor machines and that's a lot of
 Erik> machines. Some drivers are a hassle though.

FWIW, I have been using Nigel's swsusp2 for a long time now on a 2.4
kernel. It has been exceptionally well-behaved and stable. And it's an
extremely important part of my Linux world. I will not move to 2.6
unless I'm sure swsusp2 will work well.

In fact, it seems to me that many kernel developers underestimate the
importance of software suspend to actual real Linux users. I guess when
you reboot your monster PC rig five times a day to upgrade kernels, you
don't much care. But if you use a laptop and you actually care about
opening it and getting a stable, working environment within 20s, trust
me -- software suspend becomes more important to you than all the
scheduler improvements in the world.

I would gladly trade all the performance improvements of the last couple
of years for a stable, working swsusp2 and a USB subsystem which doesn't
a) prohibit my CPU from using C3 sleep and b) crash and burn regularly
bringing the whole machine down with it.

--J.

