Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbRHJNYF>; Fri, 10 Aug 2001 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRHJNXz>; Fri, 10 Aug 2001 09:23:55 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:36108 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267973AbRHJNXj>; Fri, 10 Aug 2001 09:23:39 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
Date: Fri, 10 Aug 2001 13:23:50 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9l0n95$1me$1@ncc1701.cistron.net>
In-Reply-To: <001b01c12194$a34a3370$66011ec0@frank>
X-Trace: ncc1701.cistron.net 997449830 1742 195.64.65.67 (10 Aug 2001 13:23:50 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <001b01c12194$a34a3370$66011ec0@frank>,
Frank Torres <frank@ingecom.net> wrote:
>Sorry to be insistent in this point, but perhaps requesting the problem this
>way someone figures out what I am trying to do.
>The display is already configured and sending getty line from inittab waits
>for an input from serial so it doesn't work.
>Any other ideas? This is my last try.

If you want /dev/console to behave so that it sends output to the
serial device yet takes input from the PC keyboard, no, that cannot
be done. Right now /dev/console can be associated with only one
device for both input and output at the same time.

Output from kernel printk's does go to all console devices though.

Mike.
-- 
"dselect has a user interface which scares small children"
	-- Theodore Tso, on debian-devel

