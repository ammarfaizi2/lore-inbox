Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310451AbSCGS4i>; Thu, 7 Mar 2002 13:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310450AbSCGS41>; Thu, 7 Mar 2002 13:56:27 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:59664 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S310448AbSCGS4P>; Thu, 7 Mar 2002 13:56:15 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76E0@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Jean-Luc Leger'" <reiga@dspnet.fr.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Petition Against Official Endorsement of BitKeeper by Linux M
	aintainers
Date: Thu, 7 Mar 2002 10:56:08 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 10:03 AM, Jean-Luc Leger wrote:
> > Larry McVoy <lm@bitmover.com> writes:
> > >	bk prs -hrv2.5.0.. |  while read x
> 
> by the way, shouldn't it be "$x" in the second line ?
> or am I missing something ?
> 
> 	JL

man bash
...
    read  [-ers]  [-t  timeout]  [-a  aname]  [-p  prompt] [-n
          nchars] [-d delim] [name ...] 
                              ^^^^
Nope, no "$" on the variable name in this context. The reference 
is to the variable's identifier rather than its value.

Ed Vance
