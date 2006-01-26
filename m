Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWAZUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWAZUmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWAZUmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:42:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:669 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964870AbWAZUmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:42:45 -0500
Date: Thu, 26 Jan 2006 21:42:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060125153057.GG4212@suse.de>
Message-ID: <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You just want the device naming to reflect that. The user should not
>need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
>likely be using k3b or something graphical though, and just click on his
>Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
>help do this dynamically even.

And if you have multiple cdwriters? Then (cf. other posts) one has 
/dev/cdrecorder0 /dev/cdrecrder1, etc. To me, that's just as bad as having 
/dev/sg0 and /dev/sg1, because you don't have a clue at first sight what it 
maps to.

"ls -l"? Sure, if cdrecorder0 was a symlink, but it does not work when it's 
not (= a block device in essence then).
And I'm sure there's an analog program to "ls" to find what sg0 maps to.


>If you are using cdrecord on the command line, you are by definition an
>advanced user and know how to find out where that writer is.

And GUIs could use arbitrary names like S:I:L. Ugly, but as long as it 
works... sigh.



Jan Engelhardt
-- 
