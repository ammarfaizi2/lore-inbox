Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSHZOJY>; Mon, 26 Aug 2002 10:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHZOJY>; Mon, 26 Aug 2002 10:09:24 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:16681 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S317628AbSHZOJW>;
	Mon, 26 Aug 2002 10:09:22 -0400
From: <Hell.Surfers@cwctv.net>
To: jdc843@sccoast.net, hjl@gnu.ai.mit.edu, linux-kernel@vger.kernel.org,
       gnu@gnu.org
Date: Mon, 26 Aug 2002 14:47:58 +0100
Subject: RE:I have a question about packages of programs
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1030369678076"
Message-ID: <0b3320947131a82DTVMAIL9@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1030369678076
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

We dont make the distros, just the kernel, you will learn to do stuff better, however .config stuff does suck, learn c then suggest a better idea, as one of kurt cobains friends said once"we only make music, dont know nuthin else" and config is a gcc thing, we only do thekernel...



On 	Mon, 26 Aug 2002 00:10:47 -0400 	"John D. Coleman" <jdc843@sccoast.net> wrote:

--1030369678076
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 26 Aug 2002 05:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHZEJC>; Mon, 26 Aug 2002 00:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSHZEJC>; Mon, 26 Aug 2002 00:09:02 -0400
Received: from smtp.sccoast.net ([66.153.204.5]:17927 "EHLO smtp.sccoast.net")
	by vger.kernel.org with ESMTP id <S317864AbSHZEJB>;
	Mon, 26 Aug 2002 00:09:01 -0400
Received: from sccoast.net (40.191-pool-nas3-sc.sccoast.net [66.153.191.40])
	by smtp.sccoast.net (8.12.5/8.12.5) with ESMTP id g7Q4C0D4183237;
	Mon, 26 Aug 2002 00:12:01 -0400 (EDT)
Message-ID: <3D69AA46.52A2E895@sccoast.net>
Date: Mon, 26 Aug 2002 00:10:47 -0400
From: "John D. Coleman" <jdc843@sccoast.net>
X-Mailer: Mozilla 4.7 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: hjl@gnu.ai.mit.edu, linux-kernel@vger.kernel.org,
	elenstev@mesatop.com, gnu@gnu.org
Subject: I have a question about packages of programs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-HTC-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

as in all the *.gz files that I've been grabbing from GNU and other
places.

NOTE: This email is primarily addressed to the ncurses maintainer(?)
because I liked it's documentation much better. But everyone else can
read this also.

Now, I don't know if you wrote the ncurses package or not. I found your
email address from the README.glibc file in ncurses-5.2.tar.gz

I'm new to Linux and still don't know that much about it and I used a
Slackware installation as a base from which to compile my own custom
Linux by following the information found at Linux From Scratch. Which,
in a way, is great because it is forcing me to read a LOT of
documentation about the programs that make up Linux.

I know that Linux is a 'work in progress' project but *what I really
want to know is* : Would it be too much to ask of the writers of these
programs to include in the README file or elsewhere :(1) a description
of the program, (2) A listing of the files installed, (3) A listing of
the files that are required to be present for the correct operation of
their program(s) ? A brief installation procedure followed by details of
variances of the installation procedure would be very nice also rather
than having it scattered throughout a loooong README file as is done in
the Linux Kernel README file. BTW Linux kernel - the documentation for
devfs REALLY sucks ! I can't log in as 'root' now but I can via a 'su'
from a normal user. 'Illegal login from tty1'. I'll just remove the
devfsd and reboot. That experiment failed. There was still too much
clutter in /dev anyway. I'll just see what happens if I delete unused
devices in /dev.

I've noticed that the docs in several packages like to include
instructions for how to compile a kernel. I really wish that they would
stop doing that as their instructions quickly become outdated. If the
kernel needs, or might need, to be recompiled then a reference to the
kernel sources should be all that is required. Anything else is just too
much clutter and a waste of file space on the internet's servers.

Man pages many times lists required files but they don't always list
EVERY one ! It's a pain to read the man pages of programs such as bash,
not find any references to some files that I just happen to stumble
across while reading about an entirely different program.

For instance, and the file names probably are not correct :
Say I read bash's man page because I have a problem with bash.
Then I read ncurses man page which has a reference to a file called
/etc/motd.issue that is required by bash to do something.
I then create the file /etc/motd.issue and that solves my problem.
The kicker is : I never saw a reference to the file while reading bash's
man page !
Maybe bash supposedly doesn't need that file but making it fixed the
problem.

Yes I know : 'Newbies should not be trying to compile software'. I'm no
way , no how, a newbie to computers. Just Linux. Decent documentation
should make software compilation a snap.

Sorry. I am NOT going to volunteer to rewrite documentation for programs
that you maintain. Because my first project is going to be a major
overhaul of the make and/or automake programs. That ./configure
--prefix=whatever -- src=here command-line-only-interface has got to go.
Having to read upwards of ten or more different documents, scattered in
what could be several subdirectories, just to find out what all of the
configure switches are is a real pain in the butt. Is anyone out there
using anything other than a CRT/monitor with Linux nowadays to compile
programs ?

Compiling and starting 'X' went pretty easy. I just followed
instructions.

GRIPE MODE OFF


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1030369678076--


