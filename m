Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280878AbRKYN1b>; Sun, 25 Nov 2001 08:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280890AbRKYN1X>; Sun, 25 Nov 2001 08:27:23 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:39439 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280878AbRKYN1G>; Sun, 25 Nov 2001 08:27:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Davies <james_m_davies@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.13 Kernel and Ext3 vs Ext2
Date: Sun, 25 Nov 2001 23:23:09 +1000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com> <20011125224259.A4844@higherplane.net> <EXCH01SMTP011Np7vXe00002de9@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP011Np7vXe00002de9@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011125132713Z280878-17408+19757@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 22:05, Miguel Maria Godinho de Matos wrote:
> With the kernel bug from the past few weeks, i saw my self in a situation
> where i had to upgrade/change my kernel, but didn't knew which version to
> choose.
>
> I am currently running my old 2.4.7 stable version with no known bugs ( i
> think ) but this is not what i want, So i went digging and found out that
> the kernel 2.4.13 hasn't also got no known major bugs, and so  i am
> wondering if i should compile that kernel version or wait to the 2.4.16
> final one!!!
>
> My question is, which kernel version support the ext3 partition format?
>
> My current kernel supports it, it has to as i running it, but the 2.4.14
> didn't, so i don't know which versions do support this partition  type!
>
> Another matter now:
>
> When i first installed linux red hat 7.2 one  month ago, i saw that there
> had appeard a new partition format, but as i am new to linux, and as the
> installation info about ext3 advised me that ext3 had lots of advantages
> over ext2, i choosen ext3!
>
> I want to know whether i did the right or the wrong thing, and which are
> the main differences between these two types!!!
>

AFAIK, ext3 was introduced to the kernel in 2.4.15, which is currently the 
latest, and also happens to have a bug which can ruin your filesystem.. i.e. 
dont use it. Your current kernel has ext3 support because redhat has patched 
your kernel with it (and numerous other patches). As far as upgrading kernels 
go, if your current one is fine, and you dont have any real need for features 
in a later one, then stick with your current one. If you do want to upgrade, 
2.4.13 is the latest kernel without any major bugs. It doesnt have ext3 
support but you can download a patch. ext3 is virtually the same as ext2 
anyway- a kernel with ext2 support will happily read and write ext3 without 
any problems, you just wont have journaling support.

You can also download a kernel RPM. the latest one released by redhat is 
2.4.13, and it is pretty much guaranteed to work with your current system and 
not break anything. It is also be patched with ext3 support. 

>
> ha, and before saying goodbye, where can read the complete information
> about each and every kernel release?
>

	"http://www.ramdown.com/war/kernel.html" has information on major bugs
	
	

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

