Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWCWSsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWCWSsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWCWSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:48:51 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:9159 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422656AbWCWSsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:48:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ugf61KaItvMvuQvgU7bSoCrAGCxuxbdOdWAPUsNuRCWFgT8OM00azLPJ+SV1mWKlvUQH/kw3VKCgVRos0T9UXkx//4YTi99KhIR+izYvRcbUHkem5d+gRtC8YzSWKTC6XQdvqZCYrrhvamwztw4/qarqN7OleE+6EbiQN0Rd1rI=
Date: Thu, 23 Mar 2006 19:48:32 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: marcelo.tosatti@cyclades.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Message-Id: <20060323194832.d9f153a3.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
	<20060322145132.0886f742.akpm@osdl.org>
	<20060323205324.GA11676@dmt.cnet>
	<Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 23 Mar 2006 10:15:47 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> escribió:

> IOW, just under half a _gigabyte_ of RAM is apparently considered to be 
> low end, and this is when talking about low-end (modern) hardware!

If it's considered "low-end" it's because people actually uses that
memory for something and the system starts swapping, not because it's
trendy.

The "powerful machines who never swaps" are always a minority. Being geeks
as we are we try to have the greatest machine possible, but the vast majority
of real users are "underpowered" I'm not talking of pentium 1 stuff, I can bet
there're far more pentium 4 machines with 256 MB out there than with 1 GB.

I know you don't hit those problems because you use expensive machines
with lots of ram ;) But in the _real_ world, lots of the machines are
already wasting most of its ram by running the desktop environment alone.

Diego Calleja (A user with 1 GB of RAM who usually gets his system
into swapping easily by using desktop apps and could benefit from
better page replacement policies)
