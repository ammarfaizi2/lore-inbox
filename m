Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315786AbSENPmu>; Tue, 14 May 2002 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315787AbSENPms>; Tue, 14 May 2002 11:42:48 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:23013 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S315786AbSENPml> convert rfc822-to-8bit; Tue, 14 May 2002 11:42:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: mark.gross@intel.com
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Tue, 14 May 2002 17:35:36 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <200205132218.g4DMIEw14788@unix-os.sc.intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vamsi Krishna S ." <vamsi@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205141735.36262.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

Thanks for sending the new patch, I'd be interested in the testprograms :-)

BTW: any idea what happens when a thread which is suspended happens to be in 
kernel mode? Guess this could be possible with 2.5.X... Does gdb handle that?

Regards,
Erich

On Monday 13 May 2002 21:17, you wrote:
> The following patch for 2.5.14 kernel, applies cleanly to the 2.5.15
> kernel.
>
> This work has been tested on the 2.5.14 kernel using a few pthread
> applications to dump core, from SIGQUIT and SIGSEV. This unit test has been
> done on both 2 and 4 way systems.  Further, some stress testing has been
> done where, the core files have been created while the system is under
> schedule stress from the chat room benchmark running while creating the
> core files.  This implementation seems to be quit stable under a busy
> scheduler, YMMV.  These test programs are available uppon request ;)



