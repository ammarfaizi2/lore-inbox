Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265742AbSJYAbA>; Thu, 24 Oct 2002 20:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265743AbSJYAbA>; Thu, 24 Oct 2002 20:31:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59589 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265742AbSJYAa7>; Thu, 24 Oct 2002 20:30:59 -0400
Message-Id: <200210250035.g9P0ZQD11398@eng4.beaverton.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, cmm@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Fri, 25 Oct 2002 00:59:03 BST."
             <Pine.LNX.4.44.0210250038330.1240-100000@localhost.localdomain> 
Date: Thu, 24 Oct 2002 17:35:25 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slightly offtopic ...

    > There is an insane amount of inlining in the ipc code.  I
    > couldn't keep my paws off it.
    
    I agree tempting: I thought you might like that in a subsequent patch,
    yes?  Mingming was splitting locks, not doing a cleanup of inlines.

There was a time when "inline" was a very cool tool because it had been
judged that the overhead of actually calling a function was just too
heinous to contemplate.  From comments in this and other discussions,
is it safe to say that the pendulum has now swung the other way?  I see
a lot of people concerned about code size and apparently returning to
the axiom of "if you use it more than once, make it a function."  Are
we as a community coming around to using inlining only on very tight,
very critical functions?

Rick
