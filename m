Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136412AbREGR3l>; Mon, 7 May 2001 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbREGR3d>; Mon, 7 May 2001 13:29:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61200 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S136426AbREGR3P>; Mon, 7 May 2001 13:29:15 -0400
Date: Mon, 7 May 2001 13:29:16 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Keith Owens <kaos@ocs3.ocs-net.redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4 add suffix for uname -r
In-Reply-To: <3024.989133345@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0105071132050.2244-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Keith!

> A frequent requirement is to rename vmlinuz-2.x.y to 2.x.y-old or
> 2.x.y.save to preserve a working kernel.  But renaming the image does
> not change the value of uname -r so it still tries to use modules
> 2.x.y, which defeats the purpose of saving an working kernel.

Thank you for the patch and for taking care of the problem! I've tested it
and it works for me. I'm using kernel modules and ALSA.

> Objects that "know" the value of uname -r that they were compiled with
> will not work with unamersfx.  Are there any?

"floppy" hardcodes the version but doesn't protest.

inserting floppy driver for 2.4.4-ac5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
# uname -a
Linux fonzie 2.4.4-ac5-new #3 Mon May 7 12:06:39 EDT 2001 i686 unknown

-- 
Regards,
Pavel Roskin

