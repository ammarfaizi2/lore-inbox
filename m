Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRLPSrZ>; Sun, 16 Dec 2001 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLPSrP>; Sun, 16 Dec 2001 13:47:15 -0500
Received: from [217.9.226.246] ([217.9.226.246]:128 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S284746AbRLPSq5>; Sun, 16 Dec 2001 13:46:57 -0500
To: "David Gomez" <davidge@jazzfree.com>
Cc: Dave Jones <davej@suse.de>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.33.0112161231570.650-100000@fargo>
From: Momchil Velikov <velco@fadata.bg>
Date: 16 Dec 2001 18:53:27 +0200
In-Reply-To: <Pine.LNX.4.33.0112161231570.650-100000@fargo>
Message-ID: <87snab85tk.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Gomez <davidge@jazzfree.com> writes:

David> On Sun, 16 Dec 2001, Dave Jones wrote:

>> > I'm using kernel 2.4.17-rc1 and found what i think is a bug, maybe related
>> > to the loop device. This is the situation:
>> 
>> Can you repeat it with this applied ?
>> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1/00_loop-deadlock-1

David> Thanks ;), this patch solves the problem and copying a lot of data to the
David> loop device now doesn't hang the computer.

David> Is this patch going to be applied to the stable kernel ? Marcelo ?

I've had exactly the same hangups with or without the patch.

