Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276099AbRJKLan>; Thu, 11 Oct 2001 07:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRJKLad>; Thu, 11 Oct 2001 07:30:33 -0400
Received: from nicol6.umkc.edu ([134.193.4.67]:28935 "EHLO nicol6.umkc.edu")
	by vger.kernel.org with ESMTP id <S276074AbRJKLa3>;
	Thu, 11 Oct 2001 07:30:29 -0400
Message-ID: <3BC582E7.C2C4FCC7@davidnicol.com>
Date: Thu, 11 Oct 2001 06:30:47 -0500
From: David Nicol <phuqytol@davidnicol.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en-GB, en, ru
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: OO swap interface
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1> <20011010095536.C10443@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's an idea that has been mulling under my mullet for 
the last few weeks:

the nbd can be used for a swap device, but since swap has no reason
to inform the drive about what parts of it are free, it is not possible
to have a central nbd server overcommit for multiple client swapping
nodes.

Therefore I wonder how tricky it would be to create a swap interface
that is ignorant of disk geometries.   the swap interface language
would accept requests for space, with unique handles, and would
return the swapped-out data on representation of the handle.  Like
a virtual memory hat check.






-- 
                                           David Nicol 816.235.1187
                                            1,3,7-trimethylxanthine
