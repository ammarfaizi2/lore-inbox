Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUF0IIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUF0IIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 04:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUF0IIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 04:08:39 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:987 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261234AbUF0IIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 04:08:38 -0400
Date: Sun, 27 Jun 2004 01:08:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, blaisorblade_spam@yahoo.it,
       linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-Id: <20040627010833.4019c46a.pj@sgi.com>
In-Reply-To: <20040626234025.7d69937c.akpm@osdl.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
	<20040626130945.190fb199.akpm@osdl.org>
	<20040627035923.GB8842@ccure.user-mode-linux.org>
	<20040626233253.06ed314e.pj@sgi.com>
	<20040626234025.7d69937c.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patch-scripts has the "patch-bomb" script,

Aha - interesting.

Actually, I was asking a loaded question.  I just finished writing my
own patch bomber.  I see a few details in your patch-bomb worth stealing
- thanks.  Mine is more driven off of a single text file, that specifies
what files, with what subjects, to send to whom.  And its in Python.

The big feature (?) mine has is to set the Message-Id, In-Reply-To and
References fields so that all but the first one in the set appear to be
followups to the first one, for those using threaded email readers.
Hard to do that with smtpsend in the shell ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
