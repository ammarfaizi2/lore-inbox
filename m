Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUBMJsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUBMJsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:48:41 -0500
Received: from [212.28.208.94] ([212.28.208.94]:32774 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266883AbUBMJsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:48:40 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 10:48:36 +0100
User-Agent: KMail/1.6.1
Cc: John Bradford <john@grabjohn.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402122329.11182.robin.rosenberg.lists@dewire.com> <20040213025814.GE25499@mail.shareable.org>
In-Reply-To: <20040213025814.GE25499@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131048.36658.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 03.58, Jamie Lokier wrote:
> Robin Rosenberg wrote:
> > Most shell scripts break if I even have a space in a filename.  This
> > shouldn't be any worse than that. The space issue is really serious
> > (but I don't think that can be fixed other than teaching people to
> > program properly, and possibly improving bash's knowledge of the
> > difference between a space and argument separator).
> 
> Space works fine for me.  Completion, wildcard expansion, variable
> substition etc. all fine.  Bash doesn't need changing - your scripts do.

I'm thinking about many scripts in the wild, and my own scripts (usually) handle spaces
well, but it's awkward sometimes although quoting usually resolves the issue (never mind what
happens with filenames with quotes, newlines and other garabage, but even those work sometimes. 
Fortunately these are rare, very rare and usually the result of a programming mistake elsewhere :-)

On the command line there is no problem. 

With other script languages I use this is rarely an issue.

-- robin
