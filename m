Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFFJnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFFJnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUFFJnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:43:51 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:61884 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263184AbUFFJns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:43:48 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 06 Jun 2004 11:43:47 +0200
Message-ID: <xb7hdtpyqb0.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

    Valdis> On Fri, 04 Jun 2004 22:33:41 +0300, Denis Vlasenko said:
    >> Using shell scripts instead of 'standard' init etc is way more
    >> configurable. As an example, my current setup at home:
    >> 
    >> My kernel params are:

    Valdis> Yes. Those are *YOUR* config setup parameters, that happen
    Valdis> to work with *your* specific configuration when everything
    Valdis> is operational. Some problems:

    Valdis> 1) Not all the world uses initrd....

Does ever /etc/rcS.d/* require initrd?

Moreover, not all the world uses a keyboard, either.



    Valdis> 2) I hope your /script/mount_root will Do The Right Thing
    Valdis> if the mount fails because it needs an fsck, for example.
    Valdis> Answering those 'y' and 'n' prompts can be a problem if
    Valdis> your keyboard isn't working yet..

Things even worse  can happen, too, such as  harddisk dying.  In those
problematic situations,  you'd rather boot a failsafe  partition, or a
rescue floppy, or Knoppix CD.


    Valdis> 3) Bonus points if you can explain how to, *without* a
    Valdis> working keyboard, modify that /linuxrc on your initrd to
    Valdis> deal with the situation where your keyboard setup is wrong
    Valdis> (think "booting with borrowed keyboard because your usual
    Valdis> one just suffered a carbonated caffeine overdose")...

How  do you  do the  same if  you had  only SCSI  disks, but  the SCSI
modules are not loaded or compiled in?


    Valdis> There's a *BASIC* bootstrapping problem here - if you move
    Valdis> "initialize and handle the keyboard" into userspace, you
    Valdis> then *require* that a significantly larger chunk of
    Valdis> userspace be operational in order to be able to even type
    Valdis> at the machine.  If you're trying to recover a *broken*
    Valdis> userspace, it gets a lot harder.


    Valdis> And the embedded people who use
    Valdis> "init=/onlyprogramthateverruns" are going to have a
    Valdis> significant collective cow about this....

Does embedded systems always have a keyboard?




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

