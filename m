Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131980AbQKJW0f>; Fri, 10 Nov 2000 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQKJW0Y>; Fri, 10 Nov 2000 17:26:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35332 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131983AbQKJW0Q>; Fri, 10 Nov 2000 17:26:16 -0500
Message-ID: <3A0C7517.FB96CF08@timpanogas.org>
Date: Fri, 10 Nov 2000 15:22:15 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: sendmail-bugs@Sendmail.ORG, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <Pine.GSO.4.21.0011101712390.17943-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alexander Viro wrote:
> 
> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> >
> > Then perhaps qmail's time has finally come .... If sendmail cannot run
> > on a machine with minimal background loading from a dozen or so FTP
> > clients downloading files, it's clearly sick.  BTW.  I have another box
> > running qmail, and it doesn't have these problems.
> 
> If you have permanently high load average - sure, you need to bump
> the limits. Always had been that way, nothing to do with the kernel.
> OTOH, I really don't see WTF are FTP clients giving that kind of LA -
> unless you've got really thick pipe on a box, that is. If it's a server -
> WTF are they doing there at all? And if it isn't... Nice connectivity
> you have there.

I have dual T1 lines going into the box, and I just added a 4-way ADSL
circuit as well (4 x 550K).  Claus claimed there were TCPIP timeout bugs
in Linux (which we have now disproved).  Even despite the limits being
low, a "sendmail -v -q" command should always force delivery, and this
wasn't even working right.  This box gets hammered day and night with
FTP activity.  Had to upgrade since I learned when you post a free Linux
distriution, everyone beats a path to your door.   

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
