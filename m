Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319804AbSIMWL2>; Fri, 13 Sep 2002 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319806AbSIMWL2>; Fri, 13 Sep 2002 18:11:28 -0400
Received: from holomorphy.com ([66.224.33.161]:19413 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319804AbSIMWL1>;
	Fri, 13 Sep 2002 18:11:27 -0400
Date: Fri, 13 Sep 2002 15:10:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
Message-ID: <20020913221014.GE3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com> <3D825E43.FDB41C7F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D825E43.FDB41C7F@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 02:53:07PM -0700, Andrew Morton wrote:
> So I suggest you do something local for the while, plan to use that later.
> (Actually, the implementation would probably have a heart attack if you
> asked for 100,000 pages so you may need to sit in a loop there; we'll see).

Actually, that's probably going to trip the NMI oopser.



Cheers,
Bill
