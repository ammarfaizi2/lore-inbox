Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUI0Kjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUI0Kjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUI0Kjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:39:31 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:61635 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S266626AbUI0Kj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:39:28 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Stefan Seyfried <seife@suse.de>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4157B04B.2000306@suse.de>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
	 <1096071873.3591.54.camel@desktop.cunninghams>
	 <20040925011800.GB3309@dualathlon.random>  <4157B04B.2000306@suse.de>
Content-Type: text/plain
Message-Id: <1096281162.6485.19.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 27 Sep 2004 20:32:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-09-27 at 16:16, Stefan Seyfried wrote:
> Andrea Arcangeli wrote:
> 
> > random keys are exactly fine, but only for the swap usage on a desktop
> > machine (the one I mentioned above, where the user will not be asked for
> > a password), but it's not ok for suspend/resume, suspend/resume needs
> > a regular password asked to the user both at suspend time and at resume
> > time.
> 
> Why not ask on every boot? (and yes, the passphrase could be stored on a
> fixed disk location - hashed with a function of sufficient complexity
> and number of bits, just to warn the user if he does a typo, couldn't
> it?). If suspend is working, you basically never reboot. So why ask on
> suspend _and_ resume? This also solves the "suspend on lid close" issue.
> 
> And a resume is - in the beginning - a boot, so just ask early enough
> (maybe the bootloader could do this?)
> 
> I'm not a crypto expert at all, just thinking loud...

I loved Andrea's compare-the-checksum idea, but don't see why the
passphrase is needed both times either. Then again I have zero
experience with encryption. In fact, I care so much about security that
I don't have a root password and have sudo without a password :>

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

