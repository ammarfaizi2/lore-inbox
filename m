Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129705AbRBSR3U>; Mon, 19 Feb 2001 12:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129785AbRBSR3L>; Mon, 19 Feb 2001 12:29:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:1540 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S129705AbRBSR26>; Mon, 19 Feb 2001 12:28:58 -0500
Date: Mon, 19 Feb 2001 12:28:47 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pete Zaitcev <zaitcev@metabyte.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ymfpci is 2.4.1-ac18
In-Reply-To: <E14Uttb-0003wz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0102191226030.766-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Alan Cox wrote:

> > If I load opl3, /dev/sound/sequencer becomes useful - cat doesn't exit and
> > dmesg shows:
> >
> > /dev/music: Obsolete (4 byte) API was used by cat
>
> You need opl3. The ymfpci driver is the dsp and enabler for the opl3 gunge

Then I don't understand this comment in the beginning of ymfpci.c:

 *  - 2001/01/07 Replace the OPL3 part of CONFIG_SOUND_YMFPCI_LEGACY code with
 *    native synthesizer through a playback slot.

It sounds more promising than it is :-(

Regards,
Pavel Roskin

