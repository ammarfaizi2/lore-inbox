Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVC3VHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVC3VHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVC3VFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:05:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28616 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261862AbVC3VD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:03:57 -0500
Subject: Re: [RFD] 'nice' attribute for executable files
From: Lee Revell <rlrevell@joe-job.com>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <424ACEA9.6070401@poczta.onet.pl>
References: <fa.ed33rit.1e148rh@ifi.uio.no>
	 <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
	 <424ACEA9.6070401@poczta.onet.pl>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 16:03:56 -0500
Message-Id: <1112216636.18237.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 18:07 +0200, Wiktor wrote:
> Bodo Eggert wrote:
> > Wiktor <victorjan@poczta.onet.pl> wrote:
> >>so i thought that it would be nice to add an attribute to file
> >>(changable only for root) that would modify nice value of process when
> >>it starts. if there is one byte free in ext2/3 file metadata, maybe it
> >>could be used for that? i think that it woundn't be more dangerous than
> >>setuid bit.
> > 
> > I guess there should be a maximum renice value ulimit instead, which would
> > allow running allmost any user task on a higher nice level, except the
> > important stuff, with the additional benefit of being able to temporarily
> > renice some tasks until the more important work is done.
> > 
> > I remember something similar being discussed for realtime tasks, but I don't
> > remember the outcome.
> 
> my xmms problem is unimportant here, i've posted this thread to propose 
> some new feature in filesystem, not to solve problem with multimedia player!
> 
> max renice ulimit is quite good idea, but it allows to change nice of 
> *any* process user has permissions to. it could be implemented also, but 
>   the idea of 'nice' file attribute is to allow *only* some process be 
> run with lower nice. what's more, that nice would be *always* the same 
> (at process startup)!

Please see the voluminous realtime-lsm threads for some objections to
this approach.

Lee

