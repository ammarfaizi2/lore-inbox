Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSEQMC0>; Fri, 17 May 2002 08:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEQMCZ>; Fri, 17 May 2002 08:02:25 -0400
Received: from ns.suse.de ([213.95.15.193]:64017 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314553AbSEQMCZ>;
	Fri, 17 May 2002 08:02:25 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: <Pine.LNX.4.21.0205171220480.986-100000@localhost.localdomain>
X-Yow: A KAISER ROLL?!  What good is a Kaiser Roll without a little
 COLE SLAW on the SIDE?
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 17 May 2002 14:02:20 +0200
Message-ID: <je1ycbx9rn.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

|> On Fri, 17 May 2002, Rusty Russell wrote:
|> > In message <Pine.LNX.4.21.0205170839240.1369-100000@localhost.localdomain> you 
|> > write:
|> > > On Fri, 17 May 2002, Rusty Russell wrote:
|> > > > 
|> > > > Um, show me where sizeof(KBUILD_BASENAME) + sizeof(__FUNCTION__) >
|> > > > sizeof(__FILENAME__).
|> > > 
|> > > If you're talking about kbuild2.5
|> > 
|> > No.  It's the include files, which makes up the majority of strings.
|> 
|> If they do make up the majority of strings, that's partly because
|> you don't have Andrew's out_of_line_bug work in your tree, partly
|> because your linker isn't combining strings (mine neither, does any?),

Recent gcc and ld do.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
