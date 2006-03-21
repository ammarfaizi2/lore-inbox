Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWCUNYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWCUNYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWCUNYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:24:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:54466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751678AbWCUNYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:24:15 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       bugsplatter@gmail.com
In-Reply-To: <20060321125900.GA25943@w.ods.org>
References: <1142592375.7895.43.camel@homer>
	 <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>
	 <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>
	 <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu>
	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>
	 <1142942878.7807.9.camel@homer>  <20060321125900.GA25943@w.ods.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:24:16 +0100
Message-Id: <1142947456.7807.53.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 13:59 +0100, Willy Tarreau wrote:
> On Tue, Mar 21, 2006 at 01:07:58PM +0100, Mike Galbraith wrote:

> > I can make the knobs compile time so we don't see random behavior
> > reports, but I don't think they can be totally eliminated.  Would that
> > be sufficient?
> > 
> > If so, the numbers as delivered should be fine for desktop boxen I
> > think.  People who are building custom kernels can bend to fit as
> > always.
> 
> That would suit me perfectly. I think I would set them both to zero.
> It's not clear to me what workload they can help, it seems that they
> try to allow a sometimes unfair scheduling.

Correct.  Massively unfair scheduling is what interactivity requires.

	-Mike

