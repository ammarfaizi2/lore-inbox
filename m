Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRK1Bpw>; Tue, 27 Nov 2001 20:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRK1Bpm>; Tue, 27 Nov 2001 20:45:42 -0500
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:33830 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281854AbRK1Bp3>; Tue, 27 Nov 2001 20:45:29 -0500
Message-ID: <3C0441B4.B8194BEE@mandrakesoft.com>
Date: Tue, 27 Nov 2001 20:45:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011127183418.A812@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 1.  The changes made to submit_bh indicate I can now send long
> chains of variable block size requests to the I/O layer similiar
> to the capability of Windows 2000 and NetWare I/O subsystems.

I don't want to speak for either Jens or Linus, but from what Jens was
telling me months ago, and from my reading of Jens' earlier patches,
this seems to indeed be the case.  I've been looking forward to sending
non-block-sized I/Os to and from a new filesystem I'm working on.


> 3.  In theory, I should be able to support page cache capability
> for NWFS and possibly NTFS in Linux the way these wierd non-Unix
> OS's work.

If you are hacking on NTFS please make sure to base changes on
"ntfs-driver-tng" in the "linux-ntfs" sourceforge cvs.  It is now, as of
the past week, completely modern to 2.4 vfs standards, and should
support all read-only features except attribute lists.

Regards,

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

