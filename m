Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425303AbWLHJuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425303AbWLHJuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425305AbWLHJuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:50:46 -0500
Received: from twin.jikos.cz ([213.151.79.26]:44722 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425303AbWLHJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:50:45 -0500
Date: Fri, 8 Dec 2006 10:50:18 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [git pull] Input patches for 2.6.19
In-Reply-To: <200612080157.04822.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
References: <200612080157.04822.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-873815628-1165571418=:1665"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-873815628-1165571418=:1665
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Dec 2006, Dmitry Torokhov wrote:

> Hi Linus,
> Please pull from:
> =A0 =A0 =A0 =A0 git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.=
git
> or
> =A0 =A0 =A0 =A0 master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.gi=
t
> to receive updates for input subsystem.
>  b/drivers/usb/input/hid-core.c                 |    7=20
>  b/drivers/usb/input/hid-input.c                |    4=20
>  b/drivers/usb/input/hid.h                      |    1=20

OK, this is going to break the merge from Greg's tree of generic HID=20
layer, which was planned for today.

The merge will probably emit a large .rej files, due to the large blocks=20
of code being moved around, but it seems that most of the changes which=20
would conflict with the merge could be trivially solved by hand.

Greg, should I prepare a new version of the generic HID patches against=20
merged Linus' + Dmitry's trees and send them to you?

Thanks,

--=20
Jiri Kosina
SUSE Labs

---1747641777-873815628-1165571418=:1665--
