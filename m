Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287562AbRLaQsj>; Mon, 31 Dec 2001 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287561AbRLaQs3>; Mon, 31 Dec 2001 11:48:29 -0500
Received: from ns.suse.de ([213.95.15.193]:12554 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287569AbRLaQsQ> convert rfc822-to-8bit;
	Mon, 31 Dec 2001 11:48:16 -0500
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
In-Reply-To: <20011230110623.A17083@gnu.org>
	<200112301956.OAA02630@ccure.karaya.com>
	<20011230190020.A14157@dea.linux-mips.net>
	<3C2F90E1.DADE7F54@didntduck.org>
	<20011230235939.A16384@dea.linux-mips.net>
X-Yow: ..  My pants just went on a wild rampage through
 a Long Island Bowling Alley!!
From: Andreas Schwab <schwab@suse.de>
Date: 31 Dec 2001 17:48:09 +0100
In-Reply-To: <20011230235939.A16384@dea.linux-mips.net> (Ralf Baechle's message of "Sun, 30 Dec 2001 23:59:39 -0200")
Message-ID: <jen0zz8hfa.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:

|> On Sun, Dec 30, 2001 at 05:10:41PM -0500, Brian Gerst wrote:
|> 
|> > > As user application are trying to use unistd.h and expect errno to get
|> > > set properly unistd.h or at least it's syscallX macros will have to be
|> > > made unusable from userspace or silent breakage of such apps rebuild
|> > > against new headers will occur.
|> > 
|> > Userspace should be using glibc's unistd.h.  If it's using the kernel's,
|> > it's broken.
|> 
|> A sufficient number take the unavailability of new syscall in everybody's
|> glibc as a sufficient excuse for broken code.  util-linux as a major
|> offender comes to mind or also e2fsprogs.

Userspace should be using syscall(2/3) for new syscalls.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
