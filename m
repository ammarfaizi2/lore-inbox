Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQKIXb6>; Thu, 9 Nov 2000 18:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKIXbs>; Thu, 9 Nov 2000 18:31:48 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:28681 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129324AbQKIXbi>; Thu, 9 Nov 2000 18:31:38 -0500
Date: Thu, 9 Nov 2000 16:31:24 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109163124.A31909@mail.harddata.com>
In-Reply-To: <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <3A0977A7.53641C52@mandrakesoft.com> <20001108113859.A10997@animx.eu.org> <3A098594.A85DFE0D@mandrakesoft.com> <20001108122306.A11107@animx.eu.org> <3A0989CC.2537FCEA@mandrakesoft.com> <20001109113347.B14133@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20001109113347.B14133@animx.eu.org>; from Wakko Warner on Thu, Nov 09, 2000 at 11:33:47AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 11:33:47AM -0500, Wakko Warner wrote:
> > It was posted to lkml, so no link (except if you want to dig through
> > lkml mail archives).
> 
> It booted but then it oops'ed before userland I belive.  I tried it this
> morning and didn't have much time.  It did find the scsi controller (which
> is across the bridge) and the drives attached so it does appear to be
> working.

Looks so far that I am the worst off.  If I am trying to boot with
a root on a SCSI device then either a controller is misdetected,
or goes into an infinite "abort/reset" loop, or it does not initialize
properly and disks are not found.  This is a non-exclusive, logical,
"or". :-)

Booting to an IDE device makes difference only in that that if I can
boot then SCSI disks will be simply ignored.  If somebody is interested
in a collection of dmesg outputs, with DEBUG printks, from such attempts
then I am game.  Ivan was getting these pretty consistently. :-)

   Michal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
