Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRCZL1l>; Mon, 26 Mar 2001 06:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRCZL1b>; Mon, 26 Mar 2001 06:27:31 -0500
Received: from fireball.blast.net ([207.162.131.33]:51726 "EHLO
	fireball.blast.net") by vger.kernel.org with ESMTP
	id <S132416AbRCZL1T>; Mon, 26 Mar 2001 06:27:19 -0500
Message-ID: <3ABF2679.B1E50DD7@voicenet.com>
Date: Mon, 26 Mar 2001 06:22:33 -0500
From: Uncle George <gatgul@voicenet.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-7.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, ahedrick@atipa.com, andre@suse.com,
        linux-kernel@vger.kernel.org
Subject: slow latencies on IDE disk drives( controller? )
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am processing sound data on /dev/dsp. Generally the ~61k devive buffer
is enough to keep the device satiated && gives the program time to fill
up the device buffer when there is 16k of buffer space that needs to be
filled.

But on occasion the /dev/dsp device "slurrs" ( sounds like what happens
when the speed of a tape recorder slows down due to a finger placed down
on the capstain ) unexpectedly. This was eventually traced to the usage
of an IDE disk drive. using the scsi drive does not cause the problem to
manifest itself( at least my ears say so ). but using "dd if=/dev/hda4
of=/dev/null ) does immediately cause the slurring to happen.


I think I can create a simple pgm to demo this problem, but the DATA
file that gets feed into /dev/dsp is a little large for e-mail.


/gat

