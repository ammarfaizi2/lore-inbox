Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbRBBWwv>; Fri, 2 Feb 2001 17:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRBBWwb>; Fri, 2 Feb 2001 17:52:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:63236 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130201AbRBBWw0>;
	Fri, 2 Feb 2001 17:52:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@redhat.com>
cc: john@vmlinux.net (John Morrison), reiser@namesys.com (Hans Reiser),
        mason@suse.com (Chris Mason), kas@informatics.muni.cz (Jan Kasprzak),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink 
In-Reply-To: Your message of "Fri, 02 Feb 2001 16:39:18 CDT."
             <200102022139.f12LdII21148@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 09:52:18 +1100
Message-ID: <10226.981154338@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001 16:39:18 -0500 (EST), 
Alan Cox <alan@redhat.com> wrote:
>Large numbers of people routinely build the kernel with 'unsupported' compilers

<irony>
gcc version 2.96-ia64-000717 snap 001117 - works for me doing cross
compile from ia32 to ia64.  Anybody adding #ifdef, please include this
version, oh and also include the version of gcc on the latest Redhat
ia64 beta, and the version of gcc on the latest Turbolinux ia64 beta.
Don't forget to include a check for cross compile, querying the local
rpm will not work in cross compile mode.

On second thoughts, forget about #ifdef.
</irony>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
