Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUDIRyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUDIRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:54:08 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:23098 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261416AbUDIRyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:54:04 -0400
Message-ID: <20040409175403.91924.qmail@web13904.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 9 Apr 2004 10:54:03 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I was wondering if for linux or better for a linux filesystem
>there is something like dynamic swapping of files possible.
>For explanation: I habeaccess to an Infinstor via NFS and
>linux is runnig there. This server has a nice funtion I'd
>like to have: if there are files that are not used for a
>specified time (i.e. 30 days) they are moved to another storage
>(disk and after that to an streamer tape) and are replaced
>by some kind of 'link'. So if you look at your directory you
>can see everything that was there, but if you try to open it,
>you have to wait a moment (some seconds if the file was
>swapped to another disk) oder just another moment (some
>minutes if the file is on a tape) and then it restored at
>it's old place.
>

 Good description of a HSM (Hierarchical Storage Management)
System.

>So is there anything which provides such a feature? By now
>I have a little script that moves such files out of the way and
>replaces them by links. But restoring is somewhat harder and
>it's not automatic.
>
>Any ideas?
>

 Really depends. As far as I know thare are no "free" HSM Systems
out there for Linux The only one that I am faintly familiar with
that runs on Linux is StorNext from ADIC. Definitely not free.

 DMF/Irix may now be ported to Linux (Altix/IA64), but I doubt
it will be free.

 Sun is most likely not (yet) interested in doing a Linux port
of SAM-FS (there are still Sparc/Solaris Machines to sell).
And it won't be free (my guess).

 Tivoli/IBM and UniTree are also sold for Linux. Again "sold" is
the important word

Martin


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
