Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWDGK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWDGK4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:56:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:4278 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932427AbWDGK4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:56:52 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pwil3058@bigpond.net.au, kernel@kolivas.org
In-Reply-To: <20060407095247.GA2788@elte.hu>
References: <1144402690.7857.31.camel@homer>
	 <20060407024758.22417917.akpm@osdl.org>  <20060407095247.GA2788@elte.hu>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 12:57:18 +0200
Message-Id: <1144407438.8870.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 11:52 +0200, Ingo Molnar wrote:

> i think we should try Mike's patches after smpnice got ironed out. The 
> extreme-starvation cases should be handled more or less correctly now by 
> the minimal set of changes from Mike that are upstream (knock on wood), 
> the singing-dancing add-ons can probably wait a bit and smpnice clearly 
> has priority.

(I'm still trying to find ways to do less singing and dancing.)

This patch you may notice wasn't against an mm kernel.  I was more or
less separating this one from the others, because I consider this
problem to be very severe.  IMHO, this or something like it needs to get
upstream soon.

	-Mike

