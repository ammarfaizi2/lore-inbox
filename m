Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264784AbRFSVDu>; Tue, 19 Jun 2001 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbRFSVDk>; Tue, 19 Jun 2001 17:03:40 -0400
Received: from 63-217-58-35.sdsl.cais.net ([63.217.58.35]:31244 "EHLO
	corp-p1.gemplex.com") by vger.kernel.org with ESMTP
	id <S264784AbRFSVDa>; Tue, 19 Jun 2001 17:03:30 -0400
Message-ID: <A5F553757C933442ADE9B31AF50A273B028DB9@corp-p1.gemplex.com>
From: "McHarry, John" <john.mcharry@gemplex.com>
To: "'Tom Diehl'" <tdiehl@pil.net>, linux-kernel@vger.kernel.org
Subject: RE: How to compile on one machine and install on another?
Date: Tue, 19 Jun 2001 17:04:02 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 -----Original Message-----
From: 	Tom Diehl [mailto:tdiehl@pil.net] 
Sent:	Tuesday, June 19, 2001 4:55 PM
To:	linux-kernel@vger.kernel.org
Subject:	Re: How to compile on one machine and install on another?

On Tue, 19 Jun 2001, Alan Cox wrote:

> Other than making sure you configure it for the box it will eventually run
> on - nope you have it all sorted. If you use modules you'll want to
install
> the modules on the target machine too

What is the best way to install the modules? Is there a directory _all_ of
the modules exist in b4 you do "make modules_install". I usually end up
setting EXTRAVERSION to something unique and doing a make modules_install.
That way it does not hose up the modules for the build machine.
Is there a better way?

I found it puts the new ones in a unique directory under /lib/modules.  I
just copied that also.  


I didn't go into the issues, but I am getting an error message from the
target box that "/dev/md0 must be a nonpersistent RAID0 or LINEAR array!"
This is OK in 2.2.17, which is currently running on the machine.
