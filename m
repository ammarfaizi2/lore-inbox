Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSKHSnp>; Fri, 8 Nov 2002 13:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSKHSnp>; Fri, 8 Nov 2002 13:43:45 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:37760 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262224AbSKHSno> convert rfc822-to-8bit; Fri, 8 Nov 2002 13:43:44 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Paul Larson <plars@linuxtestproject.org>, David Faure <faure@kde.org>
Subject: Re: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
Date: Fri, 8 Nov 2002 19:50:26 +0100
User-Agent: KMail/1.4.7
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200211070547.00387.Dieter.Nuetzel@hamburg.de> <3DC9F1C0.70712ED4@digeo.com> <1036779514.17557.7.camel@plars>
In-Reply-To: <1036779514.17557.7.camel@plars>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211081950.26382.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. November 2002 19:18 schrieb Paul Larson:
> On Wed, 2002-11-06 at 22:53, Andrew Morton wrote:
> > Dieter Nützel wrote:
> > > When I enable shared 3rd-level pagetables between processes KDE 3.0.x
> > > and KDE 3.1 beta2 at least do not work.
> >
> > Yup.  That's a bug which happens to everyone in the world
> > except Dave :(
>
> I've tried to reproduce this also on a RH 7.3 box.  ksmserver is
> running, but strace says it's stuck on a select() call.  There are no
> kernel messages, but I got this from startx:
>
> DCOPServer up and running.
> Warning: connect() failed: : Connection refused

That's similar to mine.

> It looks like maybe this problem shows up in different ways.

Somewhat.

> Anyone have ideas about how to debug this?

See my former post.

Maybe some KDE developers out here? 

-Dieter
