Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTKLRCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKLRCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:02:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:1720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263879AbTKLRCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:02:30 -0500
Date: Wed, 12 Nov 2003 08:58:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rob@landley.net
Cc: mzyngier@freesurf.fr, linux-kernel@vger.kernel.org
Subject: Re: Why can't I shut scsi device support off in -test9?
Message-Id: <20031112085804.0cfbaddf.rddunlap@osdl.org>
In-Reply-To: <200311120203.51599.rob@landley.net>
References: <200311120046.04348.rob@landley.net>
	<200311120126.59472.rob@landley.net>
	<wrpekwe82gw.fsf@hina.wild-wind.fr.eu.org>
	<200311120203.51599.rob@landley.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 02:03:51 -0600 Rob Landley <rob@landley.net> wrote:

| On Wednesday 12 November 2003 01:34, Marc Zyngier wrote:
| > >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
| >
| > Rob> I tried switching SCSI support off by hand (editing .config) and
| > Rob> it still showed up in the menu.  (Maybe turned back on by a
| > Rob> dependency, but on what?)
| >
| > Care to submit this .config ?

I also have no trouble disabling CONFIG_SCSI with this .config file,
using any of 'make menuconfig|xconfig|oldconfig' ($EDITOR + oldconfig).

on 2.6.0-test9 plain

A quick grep of all Kconfig files finds only USB_STORAGE that
does a "select SCSI" when it (USB_STORAGE) is enabled.

--
~Randy
MOTD:  Always include version info.
