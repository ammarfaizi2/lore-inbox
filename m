Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTAaV3H>; Fri, 31 Jan 2003 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTAaV3H>; Fri, 31 Jan 2003 16:29:07 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:36517 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S262446AbTAaV3G>;
	Fri, 31 Jan 2003 16:29:06 -0500
Date: Fri, 31 Jan 2003 22:38:27 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030131213827.GA1541@werewolf.able.es>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030131194837.GC8298@gtf.org>; from jgarzik@pobox.com on Fri, Jan 31, 2003 at 20:48:37 +0100
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.31 Jeff Garzik wrote:
> On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> > Generally, we've been trying to not make perl a prequisite for the kernel 
> > build, and I'd like to keep it that way. Except for some arch specific 
> 
> That's pretty much out the window when klibc gets merged, so perl will
> indeed be a build requirement for all platforms...
> 

So in short, kernel people:
- do not want perl in the kernel build
- allow qt to pollute the kernel to have a decent gui config tool
- have to rewrite half perl features in C
- but perl will be needed anyways

instead of
- do all parsing in perl, that is what perl is for and what is mainly done
  in kconfig scripts
- do the config backend in perl, and...
- do the gui in perl-XXX, so you can have perl-GTK, perl-GTK2, perl-QT or 
  perl-Tk, even perl-Xaw (so you get rid of tcl/tk)

I really do not understand...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
