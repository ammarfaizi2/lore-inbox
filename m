Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRHGCIF>; Mon, 6 Aug 2001 22:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270032AbRHGCHz>; Mon, 6 Aug 2001 22:07:55 -0400
Received: from dict.and.org ([63.113.167.10]:21391 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S270031AbRHGCHq>;
	Mon, 6 Aug 2001 22:07:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship>
	<20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship>
	<Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
	<s5gvgkacqlm.fsf@egghead.curl.com>
	<200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
	<20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 06 Aug 2001 22:09:59 -0400
In-Reply-To: <s5g3d78261g.fsf@egghead.curl.com>
Message-ID: <nnk80gd3ig.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Patrick J. LoPresti" <patl@cag.lcs.mit.edu> writes:


[snip sendmail/cyrus/qmail/postfix]

 Just in case anyone cares here's what exim does (AFAICS)...

 int fd1 = open(f1);
 write(fd1);
 fsync(fd1);
 
 int fd2 = open(tmp);
 write(fd2);
 fsync(fd2);
 rename(tmp, f2); // Good at this point.

 So that seems to rely on all dir operations being sync.

 Ps. I did a patch for exim to do the dir sync though...

http://www.and.org/exim-3.31-dirfsync.patch

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
