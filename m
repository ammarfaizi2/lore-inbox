Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290588AbSA3Uqr>; Wed, 30 Jan 2002 15:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290591AbSA3Uqi>; Wed, 30 Jan 2002 15:46:38 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38049
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290588AbSA3UqV>; Wed, 30 Jan 2002 15:46:21 -0500
Date: Wed, 30 Jan 2002 13:45:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130204540.GB6751@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0201301005260.1989-100000@penguin.transmeta.com> <1012419503.1460.68.camel@keller>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012419503.1460.68.camel@keller>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:38:21PM -0500, Georg Nikodym wrote:

[snip]
> and the way that people currently think (and thus speak) of these
> things, saying that you're using a version 'e' kernel is ambiguous
> because it may or may not have 'c' or 'd'.  This ambiguity also
> complicates the task of reproducing a tree at some known state later.

Well, this is what tags are for.  The ambiguity in changesets is OK,
since it's possible anyhow with multiple people (and with some creative
work maybe, 'c' would be before 'd', but at the same level, so 'c'
wouldn't get 'd', but this might break the new behavior so..)  But if
you do:
a b (tag v1) c e (tag v2)
             d
	     f (added after the v2 tag)

it should be possible to have the 'v2' tag say what changsets it had, or
even what rev of each file it was made to.

Larry, how does BK handle this now?  Ive been thinking about this for a
bit and am kind of curious now..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
