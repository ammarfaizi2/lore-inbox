Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRAGNp2>; Sun, 7 Jan 2001 08:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132050AbRAGNpS>; Sun, 7 Jan 2001 08:45:18 -0500
Received: from smtp4.mail.yahoo.com ([128.11.69.101]:36111 "HELO
	smtp4.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132039AbRAGNpC>; Sun, 7 Jan 2001 08:45:02 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A587261.5B3B99BE@yahoo.com>
Date: Sun, 07 Jan 2001 08:42:57 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: Matthias Juchem <juchem@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101070858400.7104-100000@gandalf.math.uni-mannheim.de> <m3elyfbwvp.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> Matthias Juchem <matthias@gandalf.math.uni-mannheim.de> writes:
> 
> > Or is the file name scheme reliable (/lib/libc.so.5.x.y)?
> 
> Yes, since this was how HJ named the releases.  You have to find out
> which version is actually used (there might be several .so files
> there).

Can also do:

$ strings /lib/libc.so.5|grep Linux
@(#) The Linux C library 5.4.33
$ 

BTW, people have a nasty habit of tacking their entire .config file
onto bug reports to linux-kernel.  Can you mention "grep ^C .config"
somewhere in there (or have the script do it) since the number of
config options isn't going to decrease anytime soon...

Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
