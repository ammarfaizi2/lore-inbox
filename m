Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316398AbSETVbw>; Mon, 20 May 2002 17:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316401AbSETVbv>; Mon, 20 May 2002 17:31:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31169 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316398AbSETVbv>;
	Mon, 20 May 2002 17:31:51 -0400
Date: Mon, 20 May 2002 14:18:00 -0700 (PDT)
Message-Id: <20020520.141800.52934272.davem@redhat.com>
To: frank.schafer@setuza.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1021876190.250.7.camel@ADMIN>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Frank Schaefer <frank.schafer@setuza.cz>
   Date: 20 May 2002 08:29:50 +0200

   On Mon, 2002-05-20 at 06:40, David S. Miller wrote:
   > Only Sparc implements this, that is correct.
   
   ... and that's the reason why GDB don't support follow-fork-mode for the
   intel pltform - right? ( I had a related thread on the gdb mailing list
   not soo long ago. )

I can't see any reason why lack of PTRACE_READDATA prevents follow
fork mode support in GDB.  But then again the GDB maintainers are a
bunch of pinheads so...
