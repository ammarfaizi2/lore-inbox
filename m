Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTCBJEi>; Sun, 2 Mar 2003 04:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269169AbTCBJEi>; Sun, 2 Mar 2003 04:04:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:40452 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267659AbTCBJEh>; Sun, 2 Mar 2003 04:04:37 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303020915.h229Fg8G000421@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] kernel source spellchecker
To: ms@citd.de (Matthias Schniedermeyer)
Date: Sun, 2 Mar 2003 09:15:42 +0000 (GMT)
Cc: dank@kegel.com, joe@perches.com, linux-kernel@vger.kernel.org,
       mike@aiinc.ca
In-Reply-To: <20030301212537.GA32408@citd.de> from "Matthias Schniedermeyer" at Mar 01, 2003 10:25:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >This versions defaults to only correct words within a comment. ...
> > >// Comments are easy(tm). "Everything after // until line-end".
> > >
> > >and /* ... */ are easy(tm) too because gcc doesn't support to nest them.
> > 
> > I'll be damned.  I'm impressed with how easy that was in perl.
> 
> As long as there is no nesting involved most things a easy/trivial to
> achieve with REs.

Does it cope with:

main ()
{
// /*
printf ("hello world");
// */
}

though?

John.
