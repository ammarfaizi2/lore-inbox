Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSE1KKj>; Tue, 28 May 2002 06:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSE1KKi>; Tue, 28 May 2002 06:10:38 -0400
Received: from 210-54-81-60.jetstart.xtra.co.nz ([210.54.81.60]:39877 "EHLO
	maui.stupidest.org") by vger.kernel.org with ESMTP
	id <S313307AbSE1KKh>; Tue, 28 May 2002 06:10:37 -0400
Date: Tue, 28 May 2002 00:59:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Cc: Larry McVoy <lm@bitmover.com>
Subject: Re: trivial: reiserfs whitespace
Message-ID: <20020528075937.GB1190@stupidest.org>
In-Reply-To: <20020526183128.GA11385@elf.ucw.cz> <20020527024354.GA9510@tapu.f00f.org> <20020525145325.GA16155@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 11:53:25AM -0300, Arnaldo Carvalho de Melo wrote:

    But doing it slowly, together with other patches, is not a bad
    idea.

Well, in that case is there some kind of bk or command that can be
made to automagically run to purge white-space from the end
patches/changesets as they are produced?  It would also be nice to
have hunks such as[1]:

     --- 1   Tue May 28 00:56:35 2002
     +++ 2   Tue May 28 00:56:34 2002
     @@ -1 +1 @@
     -  
     +		

stripped completely as they have no functional value and just add
bloat patches and such like.

This can be done with CVS but as it works very differently to bk
(which to be honest I really don't understand very well at all) I'm
not even sure if the above suggestion is meaningful.

   --cw

[1] View this email with something that makes white-space visible.
    Basically, 1 is ' ' and 2 is '\t\t'.
