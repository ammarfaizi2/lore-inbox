Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQKOEzu>; Tue, 14 Nov 2000 23:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQKOEzj>; Tue, 14 Nov 2000 23:55:39 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59403 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129047AbQKOEz0>;
	Tue, 14 Nov 2000 23:55:26 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011150425.eAF4P3l135592@saturn.cs.uml.edu>
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Tue, 14 Nov 2000 23:25:02 -0500 (EST)
Cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org,
        unlisted-recipients:;;;@holly-springs.nc.us; (no To-header on input)
In-Reply-To: <3A117311.8DC02909@holly-springs.nc.us> from "Michael Rothwell" at Nov 14, 2000 12:14:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell writes:

> 1) Convenient remote terminal use. 
>
> Telnet, ssh, X windows, rsh, vnc, "screen," ethernet,
> serial, etc. I think we have this one.

Nope: /dev/audio, /dev/cdrom, /dev/floppy, fonts, etc.

Also one would want a local window manager for performance,
but this tends to interfere with starting apps on the other
system.

> 4) A high reliability internal file system. 

Now we want it distributed, with version control, with
mirroring onto N of M machines and migration toward usage...

> 5) Support for selective information sharing. 
>
> Linux has a rather poor security model -- the Unix one.
> It needs ACLs no only on filesystem objects, but on other
> OS features as well; such as the ability to use network
> interfaces, packet types, display ACLs, console ACLs, etc.

It would have been nice to have just put 2 entries right
in the inode years ago. With the KISS method, we'd be using
ACLs right now. Even just a list of UIDs that would share
permission bits with the file's GID would be very useful.
I just want to share a file with one other person!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
