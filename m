Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265209AbUEYUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbUEYUnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUEYUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:43:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:61604 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265209AbUEYUnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:43:41 -0400
Subject: Re: System clock running too fast
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
To: root@chaos.analogic.com
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0405251619520.954@chaos>
References: <200405251939.47165.mbuesch@freenet.de>
	 <1085514395.11860.8.camel@athlon>  <Pine.LNX.4.53.0405251619520.954@chaos>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085517817.11860.17.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 25 May 2004 22:43:38 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar, 25/05/2004 à 16:25 -0400, Richard B. Johnson a écrit : 
> On Tue, 25 May 2004, [ISO-8859-1] Benot Dejean wrote:
> 
> > Le mar, 25/05/2004 à 19:39 +0200, Michael Buesch a écrit :
> > > Hi,
> > >
> > > I've got the problem with my server, that the system-clock
> > > is running really fast. It's running over one second too
> > > fast in one hour (aproximately).
> >
> > you should adjust it with adjtimex (there's a debian package)
> >
> 
> Ahahh.. Did you accidentally set CONFIG_MELAN in .config? That would
> do about 1 second fast per hour. If not, then do: echo "">/etc/adjtime
> (used to be you could delete it), now I think you
> need to truncate it. Sometimes this file gets corrupt and
> it takes many settings of stime to undue the corrupt-ness.

no

cat /etc/adjtime
-0.541692 1084270031 0.000000
1084270031
LOCAL

before, my /etc/adjtime was empty, i was loosing 4.36s / 24H
i sync my clock every 15days, and the difference is always < 0.1s (-0.04
average)
so i'm pretty happy with it

-- 
Benoît Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr


