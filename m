Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283720AbRLEDcJ>; Tue, 4 Dec 2001 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbRLEDb7>; Tue, 4 Dec 2001 22:31:59 -0500
Received: from mail2.alphalink.com.au ([202.161.124.58]:9754 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S283720AbRLEDbk>; Tue, 4 Dec 2001 22:31:40 -0500
Message-ID: <3C0D86C9.312E726A@alphalink.com.au>
Date: Wed, 05 Dec 2001 13:30:33 +1100
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com> <20011204182236.GM17651@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list trimmed]

Tom Rini wrote:
> 
> [...  The spec for CML2 is
> out there, and there's even a CML2-in-C project.  If you don't want to
> use Python, go help (I believe Greg Banks is who ESR mentioned is in
> charge of it) that project out [...]

  In charge of it?  I *am* it.  At least, I was it; I haven't done much
on it for a few months.  I got bogged down trying to reproduce Eric's symbol
freezing semantics with my undoable data structure, and then other things
came up.  Besides the whole Python issue seemed to have died down.

  The latest (unreleased) code has GTK and curses GUIs (the curses GUI reuses
the CML1 dialog code so it looks very much like CML1 "make menuconfig"), but
is several months behind tracking CML2 language changes.

  If people are interested in contributing, I'd be happy to put the project
on sourceforge.  But judging by the download counter for the last release at

http://www.alphalink.com.au/~gnb/gcml2/

nobody really cares ;-)  It seems my main contribution has been to provide
Eric with incentive to clarify his language spec and speed up his parser.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
