Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbRA1MQ4>; Sun, 28 Jan 2001 07:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRA1MQt>; Sun, 28 Jan 2001 07:16:49 -0500
Received: from e230.ryd.student.liu.se ([130.236.236.230]:36111 "HELO
	e230.ryd.student.liu.se") by vger.kernel.org with SMTP
	id <S130913AbRA1MQi>; Sun, 28 Jan 2001 07:16:38 -0500
Date: Sun, 28 Jan 2001 13:16:37 +0100
From: Andreas Ehliar <ehliar@lysator.liu.se>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with
Message-ID: <20010128131636.A22241@angreal.ryd.student.liu.se>
In-Reply-To: <web-2874335@suite224.net> <4687.980659746@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <4687.980659746@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Jan 28, 2001 at 04:29:06PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 04:29:06PM +1100, Keith Owens wrote:
> On Sun, 28 Jan 2001 00:13:48 -0500, 
> "Matthew Pitts" <mpitts@suite224.net> wrote:
> >Some distributions DO include the config. It may be located
> >in the /boot dir with a name CONFIG-2.2.10 or similar. I
> >know that Caldera 2.3 shiped that way(2.4 may also). If you
> >have the install CDROM, the kernel source install may have
> >it (e.g. Linux-Mandrake 7.x).
> 
> I know that some distributions ship .config but not all do.  A long way
> down on my TODO list is "submit a requirement to FHS that .config,
> System.map and other kernel related text files must be shipped in
> directory <foo>".  I would like <foo> to be /lib/modules/`uname -r`
> since that directory is already kernel specific, but we have to handle
> kernels without modules and disks with restricted size in /lib.
> However that discussion is best held on the FHS/LSB lists, not l-k.

Speaking of .config, wouldn't it make sense to add some comments to the
beginning of that file detailing at least the kernel version this config
file was generated for?
Other information like the time the file was generated could be useful as well.

regards
Andreas Ehliar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
