Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265172AbUEYU0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbUEYU0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUEYU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:26:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265172AbUEYU0I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:26:08 -0400
Date: Tue, 25 May 2004 16:25:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: System clock running too fast
In-Reply-To: <1085514395.11860.8.camel@athlon>
Message-ID: <Pine.LNX.4.53.0405251619520.954@chaos>
References: <200405251939.47165.mbuesch@freenet.de> <1085514395.11860.8.camel@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, [ISO-8859-1] Beno�t Dejean wrote:

> Le mar, 25/05/2004 à 19:39 +0200, Michael Buesch a écrit :
> > Hi,
> >
> > I've got the problem with my server, that the system-clock
> > is running really fast. It's running over one second too
> > fast in one hour (aproximately).
>
> you should adjust it with adjtimex (there's a debian package)
>

Ahahh.. Did you accidentally set CONFIG_MELAN in .config? That would
do about 1 second fast per hour. If not, then do: echo "">/etc/adjtime
(used to be you could delete it), now I think you
need to truncate it. Sometimes this file gets corrupt and
it takes many settings of stime to undue the corrupt-ness.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


