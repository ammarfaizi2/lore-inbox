Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbTCRRSN>; Tue, 18 Mar 2003 12:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCRRSN>; Tue, 18 Mar 2003 12:18:13 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:51668 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261547AbTCRRSM>; Tue, 18 Mar 2003 12:18:12 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Oleg Drokin <green@namesys.com>,
       Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: kernel nfsd
Date: Tue, 18 Mar 2003 18:28:59 +0100
User-Agent: KMail/1.5
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
References: <20030318155731.1f60a55a.skraw@ithnet.com> <20030318164204.03eb683f.skraw@ithnet.com> <20030318190733.A29438@namesys.com>
In-Reply-To: <20030318190733.A29438@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303181828.59940.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 March 2003 17:07, Oleg Drokin wrote:
> Hello!
>
> On Tue, Mar 18, 2003 at 04:42:04PM +0100, Stephan von Krawczynski wrote:
> > > The comment in the code just above the printk() reads
> > >                 /* Now that IS odd.  I wonder what it means... */
> > > Looks like you and Neil (and possibly the ReiserFS team) might want to
> > > have a chat...
> >
> > I'm all for it. Who has a glue? I have in fact tons of these messages,
> > it's a pretty large nfs server.
>
> What is the typical usage pattern for files whose names are printed?
> Are they created/deleted often by multiple clients/processes by any chance?
>


Hi,

we also sometimes see those messages. In our case it seems to appears rather 
often for the local/share/perl directory of our /usr/local directory:

nfsd-fh: found a name that I didn't expect: share/perl

This directory is certainly never deleted when this message appears, actually 
data are very, very seldem written to it.

Once this message also appeared for a file:
servicetypes/kdeveloplanguagesupport.desktop

I can't tell you how often kde deletes this file.

Please ask if you need more information.

Bernd
