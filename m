Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbTCLUjd>; Wed, 12 Mar 2003 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbTCLUjc>; Wed, 12 Mar 2003 15:39:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12558 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261982AbTCLUjY>; Wed, 12 Mar 2003 15:39:24 -0500
Message-ID: <3E6F9D61.8090009@zytor.com>
Date: Wed, 12 Mar 2003 12:49:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: John Bradford <john@grabjohn.com>, dana.lacoste@peregrine.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
References: <3E6F6E84.1010601@zytor.com> <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk> <20030312180304.GA30788@work.bitmover.com>
In-Reply-To: <20030312180304.GA30788@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
>>I thought that BK has been able to export everything to a text file
>>since the first version.
> 
> 
> bk export -tpatch -r1.900 > patch.1.900
> bk changes -v -r1.900 > comments.1.900
> 
> Been there forever.  So has ways to get all the metadata from the command
> line without having to reverse engineer the file format.  See
> 
>     http://www.bitkeeper.com/manpages/bk-prs-1.html
> 
> it's all there.  Always has been.
> 
> Wayne wanted me to point that it is easy to write the BK to CVS exporter
> completely from the command line, we prototyped it that way, the only
> reason we rewrote part of it in C was for performance.  The point being
> that you guys could have done this yourself without help from us because
> all the metadata is right there.  Ditto for anyone else worried about 
> getting their data out of BK now or in the future.  The whole point of
> prs is to be able to have a will-always-work way to get at the data or
> the metadata, it makes the file format a non-issue.  
>

This is a Good Thing[TM] for a whole bunch of reasons.

Maybe this output could be made available automatically in addition to
the CVS tree?  If bandwidth is a concern then I reiterate what I said
offline yesterday, if you can give me a ballpark idea of what the
requirements seem to be I'll start hunting for a place to park a
.kernel.org server dedicated to this task.

	-hpa



