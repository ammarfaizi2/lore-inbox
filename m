Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbRLPTzi>; Sun, 16 Dec 2001 14:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284791AbRLPTz2>; Sun, 16 Dec 2001 14:55:28 -0500
Received: from [217.9.226.246] ([217.9.226.246]:4224 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S284780AbRLPTzP>; Sun, 16 Dec 2001 14:55:15 -0500
To: "David Gomez" <davidge@jazzfree.com>
Cc: Dave Jones <davej@suse.de>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.33.0112162036370.475-100000@fargo>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0112162036370.475-100000@fargo>
Date: 16 Dec 2001 21:50:23 +0200
Message-ID: <877krnq70g.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Gomez <davidge@jazzfree.com> writes:

David> On 16 Dec 2001, Momchil Velikov wrote:

>> [...]
>> 
David> Thanks ;), this patch solves the problem and copying a lot of data to the
David> loop device now doesn't hang the computer.
>> 
David> Is this patch going to be applied to the stable kernel ? Marcelo ?
>> 
>> I've had exactly the same hangups with or without the patch.

David> I've tested several times after applying the loop-deadlock patch and the
David> bug seems to be fixed. No more hangups while copying a lot of data to
David> loopback devices. Post more info about your hangups, maybe is another
David> different loop device deadlock.

Maybe it's different I don't know. Looks like I've found a fix and in
a minute I'll test _without_ the Andrea's patch and post whatever
comes out of it.

Regards,
-velco
