Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUBQJpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 04:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUBQJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 04:45:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:57021 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264538AbUBQJpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 04:45:22 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 17 Feb 2004 10:33:01 +0100
From: Gerd Knorr <kraxel@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ (ir-kbd-gpio.ko)
Message-ID: <20040217093300.GA6571@bytesex.org>
References: <20040201100644.GA2201@ucw.cz> <20040201215438.GA8937@localhost> <20040216224226.GB322@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216224226.GB322@elf.ucw.cz>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The following is not a problem, but a question I have been unable to
> > answer by myself. Is with respect to the recent addition of "input layer
> > based support for infrared remote controls", mainly for use with TV
> > tuner cards based on bttv.

> Exactly. With this driver, this is just another keyboard, not lirc
> device. You should not need lircd.

The cvs version can also work with the linux event layer, so it is
possible to use lircd if you want.  It isn't mandatory through.

Documentation/video4linux/README.ir has some more notes.

  Gerd

