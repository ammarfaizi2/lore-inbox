Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSABOFi>; Wed, 2 Jan 2002 09:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287828AbSABOFf>; Wed, 2 Jan 2002 09:05:35 -0500
Received: from admin.nni.com ([216.107.0.51]:53264 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S287832AbSABODq>;
	Wed, 2 Jan 2002 09:03:46 -0500
From: "Andrew Rodland" <arodland@noln.com>
Subject: Re: CML2 funkiness
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5
Date: Wed, 02 Jan 2002 09:03:45 -0500
Message-ID: <web-54668623@admin.nni.com>
In-Reply-To: <200201010217.g012H2d00406@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, I'd like to apologize for lack of all the
 information I'd like to have, I'm at school, and
 temporarily semidisconnected at home.

CML2 is definitely still not quite right for me
(2.4.17 + kpreempt-rml, latest CML2 as of 3ish days ago).

Menuconfig and friends seem okay, as far as I can tell (and
 they've apparently been tested pretty well), but oldconfig
 is wacky...

Basically, it seems to have random (but deterministic)
 amnesia: It forgets the answers to certain questions,
 apparently on write-out.

So, "mv config .config ; make mrproper ; mv config .config
 ; make oldconfig" does odd things to my config, but more
 in-your-face, on "make oldconfig ; make oldconfig" (ad
 inifinitum if you want), it will continue asking the same
 questions, and never remember the answer.

I'm 99% sure the problem is on the write-out, rather than
 the read in, but I'll go do some extra digging tonight.
 Python isn't really my language. Yet, at least. :)

Anyway, thanks for reading. If you need more information,
 let me know. I'm subscribed to the 100k digest.

--Andrew Rodland
