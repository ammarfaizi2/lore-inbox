Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129182AbQKEKtz>; Sun, 5 Nov 2000 05:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbQKEKtp>; Sun, 5 Nov 2000 05:49:45 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:41090 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129770AbQKEKtb>; Sun, 5 Nov 2000 05:49:31 -0500
Date: Sun, 5 Nov 2000 10:49:14 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com, sbest@us.ibm.com, linuxjfs@us.ibm.com
Subject: Re: ext3 vs. JFS file locations...
In-Reply-To: <200011050253.eA52rfc515962@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.10.10011051047420.6059-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Albert D. Cahalan wrote:

> Dominik Kubla writes:
> > On Fri, Nov 03, 2000 at 11:33:10AM -0800, H. Peter Anvin wrote:
> 
> [about IBM's JFS and ext3 both wanting to put code in fs/jfs]
> 
> >> How about naming it something that doesn't end in -fs, such as
> >> "journal" or "jfsl" (Journaling Filesystem Layer?)
> >
> > Why?  I'd rather rename IBM's jfs to ibmjfs and be done with it.
> 
> jfs == Journalling File System
> 
> The journalling layer for ext3 is not a filesystem by itself.
> It is generic journalling code. So, even if IBM did not have
> any jfs code, the name would be wrong.
> 
> IBM ought to change their name too, because the code they ported
> can not mount AIX's current filesystems. An appropriate name
> would be jfs2 or os2jfs, to distinguish it from the original.
> If the AIX filesystem is ever implemented for Linux, then that
> code can get the jfs name.

How about "Journalling Support Layer (JSL)"?

How different is AIX's JFS from OS/2's? Is there any possibility of the
current code being able to handle AIX filesystems as well, or is it a
different system entirely? If the latter, I'd agree with something like
"os2jfs".


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
