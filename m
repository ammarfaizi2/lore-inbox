Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUK0HGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUK0HGN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUK0HFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:05:43 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64410 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261389AbUKZTHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:55 -0500
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041126000853.GL2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101298112.5805.330.camel@desktop.cunninghams>
	 <20041125233243.GB2909@elf.ucw.cz>
	 <1101427035.27250.161.camel@desktop.cunninghams>
	 <20041126000853.GL2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101428250.27250.188.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 11:17:30 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Fri, 2004-11-26 at 11:08, Pavel Machek wrote:
> Kernel boot is not expected to be interactive. I'd do
> 
> if (can_erase_image)
> 	printk("Incorrect kernel version, image killed\n");
> else
> 	panic("Can't kill suspended image");
> 

Comes down, again, to user friendliness. Just because I can erase the
image, doesn't mean I should. It may be that the user just pressed the
down arrow one too few times in lilo, and they really do have the right
kernel, but started the wrong one. Or it may be that they're still
setting up their initrd, didn't get it quite right, know that no damage
will be done and want to continue booting. We should let the user think
about what they want to do and then do it.

I need to get on with the work I planned on doing today, so I'm going to
hang up after sending this. That's not at all to say that I want you to
stop sending email; just that I won't be replying for a while.

Once again, thanks very much for your effort. It is good to be made to
defend design decisions and to see where you could do things better or
took things for granted that 'aint necessarily so.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

