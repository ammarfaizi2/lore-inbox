Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJHOTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTJHOTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:19:05 -0400
Received: from lucidpixels.com ([66.45.37.187]:8926 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261546AbTJHOTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:19:00 -0400
Date: Wed, 8 Oct 2003 10:18:49 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
cc: technical@abit-usa.com, sales@abit-usa.com
Subject: ABIT IC7-G Motherboard Does Not Power Off In Linux 2.4.2[1-2]
Message-ID: <Pine.LNX.4.58.0310081006240.27118@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# shutdown -i 0 -g 0 -y

On the first revision of the bios (3/27, 1.0) it would power off with no
problems.

On the newest revision of the bios (8/28, 1.7) it gets to Power Down and
then hangs (does not fully power off).

I've asked on newsgroups and forums, people who run windows have no
problems shutting down, it seems to be a linux-specific problem.

I've used 2.4.21, 2.4.21 with this motherboard.

I do not want to use the old BIOS because I get occasional kernel panics,
why, I have no idea, although I would venture to guess it has something to
do with the i8xxx random number generator driver, hw support.

I have e-mailed abit and lkml in the past but received no response.

With the new BIOS, I never experience any lockups or kernel panics, but I
cannot power off the machine except by pressing the button.

After executing: shutdown -i 0 -g 0 -y
Gets to:
Flushing hda hdb hdc, etc, then
Power Down.

But then it stays here, everything stays on, the video, the box, etc.

The most important to kernel developers(?) is probably the bios changelog:
http://www.abit-usa.com/downloads/bios/bios_revision.php?categories=1&model=4

Something, I do not know what changed so shutting down is just not
possible anymore, I would like to get to the root of the problem.

The motherboard is based on the Intel 875P chipset, further specifications
are availible from their site:
http://www.abit-usa.com/products/mb/products.php?categories=1&model=4

The manual is here:
http://salebios.tiger2.net/vendor/ABIT/manual/english/ic7-g.pdf

I do believe this is a kernel related issue somewhat, due to reviewing the
abit forums and not finding anyone with this problem, although most users
are windows users.  As well as asking on the abit newsgroup and not
getting any helpful response either.

I'd run the old bios but I cannot deal with random kernel panics when I am
trying to get work done.

Does anyone have any suggestions how to debug or fix this problem?


