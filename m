Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTJDO4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 10:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJDO4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 10:56:32 -0400
Received: from mail.midmaine.com ([66.252.32.202]:28345 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S262098AbTJDO4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 10:56:31 -0400
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD680, kernel 2.4.21, and heartache (fwd)
X-Eric-Conspiracy: There Is No Conspiracy
References: <Pine.GSO.4.21.0310040757010.6486-100000@dirac.phys.uwm.edu>
From: Erik Bourget <erik@midmaine.com>
Date: Sat, 04 Oct 2003 10:55:28 -0400
In-Reply-To: <Pine.GSO.4.21.0310040757010.6486-100000@dirac.phys.uwm.edu> (Bruce
 Allen's message of "Sat, 4 Oct 2003 08:06:32 -0500 (CDT)")
Message-ID: <87he2paw7z.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Allen <ballen@gravity.phys.uwm.edu> writes:

>> Yeah, it says 196, and that's bizarre.  196 whats?  From looking at other
>> example output, the '1441854' number is usually the true deg. C of the
>> machine.  But I'm reasonably sure that it's not at a million and a half
>> centigrade.
>
> You need to use a more recent version of smartctl -- one with better
> documentation and clearer output.  Get smartmontools 5.1-18 from
> http://smartmontools.sourceforge.net/ and read the documentation. Don't
> use the 5.19 release -- it's flawed.
>
> This should answer your questions. If not, post the output from (the
> smartmontools 5.1-18 version of) smartctl -a and I'll comment.
>
> [Regarding the temperature, the Drive ID string in your output was:
> Device: IC35L120AVV207-0 which is an IBM/Hitachi drive, not a Samsung
> drive as you stated in your original post.  If so, the drive stores three
> temperatures internally in six bytes.  smartmontools will display all
> three temperatures (current, lifetime min and lifetime max).  The outdated
> version of smartctl that you are using simply prints the bottom four of
> the six bytes -- hence the very large number] .

Right you are.  I'm sorry, I thought they were Samsungs at first, saw
otherwise after that post, figured it wasn't a major point of contention.
But, IBM --- doesn't their hard drive division not exist anymore because of
massive failures?

- Erik

