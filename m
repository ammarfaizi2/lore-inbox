Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTCESdM>; Wed, 5 Mar 2003 13:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTCESdM>; Wed, 5 Mar 2003 13:33:12 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:35525 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S267425AbTCESdL>; Wed, 5 Mar 2003 13:33:11 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
From: Derek Atkins <derek@ihtfp.com>
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
References: <sjmof4pvfx7.fsf@kikki.mit.edu>
	<20030305182715.A27888@infradead.org>
Date: 05 Mar 2003 13:43:30 -0500
In-Reply-To: <20030305182715.A27888@infradead.org>
Message-ID: <sjmbs0pvelp.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> It's new in glibc 2.3

Ahh.. Thanks.  I'm still using older versions myself.

> #ifdef <OS> is a very bad style.  As you're already using autoconf
> I'd suggest just checking for HAVE_GETIFADDRS

Well, the problem is that the replacement function is only valid on
Linux, so I need to have the <OS> test in there anyways.  It may be
"bad style", but the test needs to exist _somewhere_.  Besides, I've
never been one to be convinced to do something purely based on
stylistic arguments.  Give me a real technical reason why it needs to
be different and I'll consider changing it.

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
