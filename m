Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUGOS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUGOS2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUGOS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 14:28:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32658 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266271AbUGOS2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 14:28:05 -0400
Message-ID: <004401c46a99$7828b210$f6e40718@mxdogxp>
From: "mxdog" <mxdog@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: palo hp k server-Debian- bugs to follow-parisc 
Date: Thu, 15 Jul 2004 13:28:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

ok im lost palo doent seem to work ...i have a hp 9000 k860. after many
tries finally got a system on one of my drives. I'm pure scsi  with 24 9.1G
drives so the system i finaly got running was  at sdc ....this was debian
net install for reference..  I'm trying  to do the simplest thing in the
world ...change the ipl command line from sdc to sda and palo -U doesnt seem
to work....

when i boot ipl says this command line "2/boot/vmlinux root=/dev/sdc5 HOME=/
console=ttyB0 TERM=vt102" buy the way this doesnt work what works is (when
was sdc0 ) 2/vmlinux  root=/dev/sdc rest the same..this is the debian
install so not sure what scripts where used but they dont work from install
i have to edit every boot.

what i need is the command line to say ..."2/vmlinux root=/dev/sda5" etc

the palo command line wont do this ....i've tried many combos but the one i
was sure would work was

palo -U /dev/sda -c "2/vmlinux root=/dev/sda5...etc"

my question is how the hell to i get palo to re-write the command line in
the boot loader or do i have to make ipl etc... the how-to's out there tell
me exactly what to do but they dont work or i'm missing something really
simple that other people take for granted. like maybe have to recompile a
kernel ..make palo ...make ipl doesnt work either .......i'm still debugging
kernel compiles ....one my 5th crash so far ....will be a heck of a bug
report when im done.  The howto's are not step by step so i'm pretty sure im
doing something just DUMB.

thx
mx

ps. your name and email is on the error code so if i got the wrong guy
please forward or point me to the correct person to yak at.....i just want
to make this work ..i got 23 drives i want to get up and running and web
pages to serve:)))

pps: this was originally for bame@c3k address not allowed or accepted








