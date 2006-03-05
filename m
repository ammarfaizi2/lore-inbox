Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWCEV1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWCEV1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCEV1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:27:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:49333 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751811AbWCEV1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:27:32 -0500
X-Authenticated: #14349625
Subject: Re: Doubt about scheduler
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: =?ISO-8859-1?Q?Ra=FAl?= Baena <raul_baena@ya.com>, jonathan@jonmasters.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <440AE7E3.4060500@yahoo.com.au>
References: <4407584A.60301@ya.com>
	 <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
	 <440AE3F3.3090404@ya.com>  <440AE7E3.4060500@yahoo.com.au>
Content-Type: text/plain; charset=utf-8
Date: Sun, 05 Mar 2006 22:27:34 +0100
Message-Id: <1141594054.7710.18.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 00:30 +1100, Nick Piggin wrote:
> Raúl Baena wrote:
> > Thank you very much Jon. But I think I haven´t explained very well.
> > 
> > I know that now the prio_array and runqueues structs aren´t accesible 
> > for modules, but in the 2.6.5 version they were. I would like to know 
> > the reason, why before they were accesible and now they don´t? If you 
> > could answer me, it would be great.
> 
> I don't remember them being available in 2.6.5... but as to why they
> aren't available now: it is much cleaner this way. It even benefits
> you because now nobody will break your module when they change the
> data structure.

I can't recall having ever seen these exposed.. by Ingo.

	-Mike 

