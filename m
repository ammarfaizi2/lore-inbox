Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUIAMdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUIAMdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIAMdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:33:51 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:4525 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266310AbUIAMcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:32:55 -0400
Date: Wed, 1 Sep 2004 13:32:31 +0100
From: Dave Jones <davej@redhat.com>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Message-ID: <20040901123231.GA10829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
References: <200409021453.09730.aero_climb@yahoo.fr> <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com> <200409021614.10377.aero_climb@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409021614.10377.aero_climb@yahoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 04:14:09PM +0200, Romain Moyne wrote:
 > Le Mercredi 01 Septembre 2004 14:15, Zwane Mwaikambo a écrit :
 > > On Thu, 2 Sep 2004, Romain Moyne wrote:
 > > > Hello, I'm french, sorry for my bad english :(
 > > >
 > > > I have a problem with my kernel: Time runs exactly three times too fast.
 > > >
 > > > I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success.
 > > > It is really strange because yesterday I reinstalled my debian with a
 > > > kernel 2.6.8.1 (made by me): Time ran correctly. And this morning when I
 > > > rebooted my computer (Compaq presario R3000 series, R3215EA exactly) the
 > > > time is running again three times too fast (with the kernel 2.6.8.1 and
 > > > 2.6.9-rc1).
 > > >
 > > > All my applications (KDE, command "date"...) runs three times too fast.
 > > > It's very annoying.
 > >
 > > Can you try this without cpuspeed or some frequency control daemon
 > > running? So disable it in runlevel scripts and then reboot.
 > 
 > I have not cpuspeed or some frequency control daemon running. I just have 
 > this:
 > 
 > presario:/etc/rc2.d# ls
 > S10sysklogd  S20alsa   S20makedev  S20xprint  S99kdm            S99xdm
 > S11klogd     S20exim4  S20pcmcia   S89atd     S99rmnologin
 > S14ppp       S20inetd  S20xfs      S89cron    S99stop-bootlogd
 > presario:/etc/rc2.d#

Do you get any messages prefixed with 'cpufreq' or 'powernow' in your
dmesg output ?
Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
If so, what do they contain?

		Dave

