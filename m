Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTDKWLx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbTDKWLx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:11:53 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:61839 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261533AbTDKWLw (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:11:52 -0400
Date: Fri, 11 Apr 2003 18:21:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel support for non-English user messages
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304111823_MC3-1-3412-C273@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought you might be seriously in need of some mental evaluation
> when you claimed that users "liked looking up error numbers in
> manuals".


 Not the looking up part, but that fact that the explanation
for every single message the software could emit was available.

 Today it's all HTML documents or PDFs or something, but it's still
a staggering amount of information.  I have ~300MB of Oracle
documentation on one desktop, 6 of it server error messages alone.
Every possible message is explained to some extent, except this one:


-----------------------------------------------------------------------
ORA-00600 internal error code, arguments: [string], [string], [string],
                   [string], [string], [string], [string], [string]

Cause: This is the generic internal error number for Oracle program
exceptions. It indicates that a process has encountered a low-level,
unexpected condition.
<SNIP>
The first argument is the internal message number. Other arguments
are various numbers, names, and character strings. The numbers may
change meanings between different versions of Oracle. 

Action: Report this error to Oracle Customer Support after gathering
the following information:
<SNIP>
Note: The cause of this message may manifest itself as different errors
at different times. Be aware of the history of errors that occurred
before this internal error. 
-----------------------------------------------------------------------


which is currently pretty much the only explanation available for
a whole lot of Linux error messages. I can go read the source when e.g.
the md driver splats its internal status dumps all over the console
during array rebuild, but that doesn't help much.


> Whee. April first is long gone, but the jokers stay around.


 Our kind knows no season.


--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
