Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSE1XKS>; Tue, 28 May 2002 19:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSE1XKR>; Tue, 28 May 2002 19:10:17 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:44040 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S312254AbSE1XKQ>; Tue, 28 May 2002 19:10:16 -0400
Date: Tue, 28 May 2002 16:10:13 -0700
From: jw schultz <jw@pegasys.ws>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: trivial: reiserfs whitespace
Message-ID: <20020528161013.H885@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020526183128.GA11385@elf.ucw.cz> <20020527024354.GA9510@tapu.f00f.org> <20020525145325.GA16155@conectiva.com.br> <20020528075937.GB1190@stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 12:59:37AM -0700, Chris Wedgwood wrote:
> On Sat, May 25, 2002 at 11:53:25AM -0300, Arnaldo Carvalho de Melo wrote:
> 
>     But doing it slowly, together with other patches, is not a bad
>     idea.
> 
> Well, in that case is there some kind of bk or command that can be
> made to automagically run to purge white-space from the end
> patches/changesets as they are produced?  It would also be nice to
> have hunks such as[1]:
> 
>      --- 1   Tue May 28 00:56:35 2002
>      +++ 2   Tue May 28 00:56:34 2002
>      @@ -1 +1 @@
>      -  
>      +		
> 
> stripped completely as they have no functional value and just add
> bloat patches and such like.
> 
> This can be done with CVS but as it works very differently to bk
> (which to be honest I really don't understand very well at all) I'm
> not even sure if the above suggestion is meaningful.
> 
>    --cw

CW makes an interesting point.  Perhaps bk could be
configured to check for / +\t/ and /\s+$/ on changed lines,
and possibly their contigious neighbors, and ask about purging
the superfluous whitespace.  Comments Larry?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
