Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318596AbSGSRD1>; Fri, 19 Jul 2002 13:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSGSRD0>; Fri, 19 Jul 2002 13:03:26 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:49935 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S318596AbSGSRDR>; Fri, 19 Jul 2002 13:03:17 -0400
Date: Fri, 19 Jul 2002 19:09:08 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Julian Bradfield <jcb@dcs.ed.ac.uk>
Subject: Re: [PATCH] aha152x fix
In-Reply-To: <20020718222805.GA16641@linux-buechse.de>
Message-ID: <Pine.LNX.4.21.0207191834490.6083-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Juergen E. Fischer wrote:

> > Due to NULL pointer dereferencing I'm getting an Oops - see below. This
> > was taken from the console with the aha152x running with debug enabled.
> > And yes, this should be completely unrelated to the detection problem.
> 
> Following patch against 2.4.19-rc2 fixes that problem.  The patch also
> includes a fix for a timeout problem with a tape drive (reported Julian
> Bradfield).

Works for me now. Device detection ok. Did some test scanning without any
problem. Since the Oops was 100% reproducible I'd say it's really fixed
now - Thanks.

Hopefully we can still get this into -final or the aha152x would be
unusable with 2.4.19 (that's why I still haven't shortened the CC-list)

Martin

