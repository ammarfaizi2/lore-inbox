Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281512AbRKHLAb>; Thu, 8 Nov 2001 06:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281511AbRKHLAW>; Thu, 8 Nov 2001 06:00:22 -0500
Received: from [213.98.126.44] ([213.98.126.44]:45715 "HELO mitica.trasno.org")
	by vger.kernel.org with SMTP id <S281509AbRKHLAI>;
	Thu, 8 Nov 2001 06:00:08 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>
	<5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
	<5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
	<3BE99650.70AF640E@zip.com.au> <3BE99650.70AF640E@zip.com.au>
	<20011107133301.C20245@mikef-linux.matchmail.com>
	<3BE9AF15.50524856@zip.com.au>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3BE9AF15.50524856@zip.com.au>
Date: 08 Nov 2001 11:58:18 +0100
Message-ID: <m2g07pmsvp.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "andrew" == Andrew Morton <akpm@zip.com.au> writes:

andrew> Mike Fedyk wrote:
>> 
>> I have a switch "data=journal" that ext2 will choke on when I boot into an
>> ext2 only kernel.
>> 
>> Is there another way to change the journaling mode besides modifying
>> /etc/fstab?

andrew> Try  adding `rootflags=data=journal' to your kernel boot
andrew> commandline.

That normally fails if you are using ext3 as a module :(

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
