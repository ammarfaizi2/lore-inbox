Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVDWSuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVDWSuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDWSuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:50:32 -0400
Received: from smtpout.mac.com ([17.250.248.97]:50370 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261698AbVDWSuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:50:07 -0400
In-Reply-To: <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org>
References: <4ae3c14050417085473bd365f@mail.gmail.com> <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4a5cc1ac18788e708f9a5f3a5bd31be0@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Why Ext2/3 needs immutable attribute?
Date: Sat, 23 Apr 2005 14:49:59 -0400
To: dean gaudet <dean-list-linux-kernel@arctic.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 23, 2005, at 12:50, dean gaudet wrote:
> On Sun, 17 Apr 2005, Xin Zhao wrote:
>
>> Why not simply unset the write bit for all three groups of users?
>> That seems to be enough to prevent file modification.
>
> another usage:  if you "chattr +i /var" while /var is unmounted, then 
> root
> is unlikely to accidentally create files/dirs in /var -- and when you
> mount the real /var on top it works fine.  i tend to protect all my 
> mount
> points this way (especially those in /mnt) to avoid my own dumb 
> mistakes.

If you chmod 000 /var beforehand (While it's still unmounted, of 
course),
then it's also blindingly obvious that it's not mounted in an ls -l :-D.
I too have used this trick on many/most of my systems.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


