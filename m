Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132664AbRA1F3j>; Sun, 28 Jan 2001 00:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRA1F3a>; Sun, 28 Jan 2001 00:29:30 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32011 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132664AbRA1F3M>;
	Sun, 28 Jan 2001 00:29:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Matthew Pitts" <mpitts@suite224.net>
cc: Jacob Anawalt <anawaltaj@qwest.net>, linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with 
In-Reply-To: Your message of "Sun, 28 Jan 2001 00:13:48 CDT."
             <web-2874335@suite224.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jan 2001 16:29:06 +1100
Message-ID: <4687.980659746@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 00:13:48 -0500, 
"Matthew Pitts" <mpitts@suite224.net> wrote:
>Some distributions DO include the config. It may be located
>in the /boot dir with a name CONFIG-2.2.10 or similar. I
>know that Caldera 2.3 shiped that way(2.4 may also). If you
>have the install CDROM, the kernel source install may have
>it (e.g. Linux-Mandrake 7.x).

I know that some distributions ship .config but not all do.  A long way
down on my TODO list is "submit a requirement to FHS that .config,
System.map and other kernel related text files must be shipped in
directory <foo>".  I would like <foo> to be /lib/modules/`uname -r`
since that directory is already kernel specific, but we have to handle
kernels without modules and disks with restricted size in /lib.
However that discussion is best held on the FHS/LSB lists, not l-k.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
