Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUF3IEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUF3IEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUF3IEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:04:49 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:61230 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S266324AbUF3IEp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:04:45 -0400
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: Debi Janos <debi.janos@freemail.hu>
To: John Heffner <jheffner@psc.edu>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, shemminger@osdl.org
In-Reply-To: <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
References: <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
Content-Type: text/plain; charset=ISO-8859-2
Message-Id: <1088582682.911.7.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 10:04:52 +0200
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 30 Jun 2004 08:04:43.0904 (UTC) FILETIME=[E7125000:01C45E78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2004-06-29, k keltezéssel 23:36-kor John Heffner ezt írta:

> Sigh.  I ran in to this problem a year or so ago and it was a broken
> firewall that was mangling the TCP window scale option.  I think the
> firewall was an OpenBSD machine, and I was told the problem went away with
> an upgrade.  I'm curious what they're running here.
> 
> The boundary 3 is special because it causes SWS avoidance to break.
> 
>   -John

hmm. interesting. my server sits behind an openbsd packet filter... , but the gentoo's machines uses iptables firewall...


