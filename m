Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRAJADU>; Tue, 9 Jan 2001 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130508AbRAJADK>; Tue, 9 Jan 2001 19:03:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130397AbRAJAC4> convert rfc822-to-8bit; Tue, 9 Jan 2001 19:02:56 -0500
Date: Tue, 9 Jan 2001 16:02:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jakob Østergaard <jakob@unthought.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hubert Mantel <mantel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <20010110004917.A861@unthought.net>
Message-ID: <Pine.LNX.4.10.10101091559560.2815-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id QAA28031
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Jakob Østergaard wrote:
> 
> Besides, most people using Software RAID have been using 0.90 for
> at least two years - so I doubt this would have been much of a problem
> if the 0.90 patches weren't available for 2.2, which they are.

This is probably th eimportant part. Most heavy RAID 2.2.x users have in
fact probably already used the "new" 2.4.x interface for some time.

I do agree with Alan, though: the decision on making that the _official_
2.2.x interface is a nasty decision. It will screw some people, and they
would be right in being unhappy about interface changes in the middle of a
stable kernel release.

For 2.2.x I suspect that 0.90 should continue to just be a (common) extra
patch.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
