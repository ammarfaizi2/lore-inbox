Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWETXYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWETXYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWETXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:24:49 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:11360 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964829AbWETXYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:24:48 -0400
Date: Sat, 20 May 2006 16:24:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
Message-ID: <20060520232445.GA11232@taniwha.stupidest.org>
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520090614.GA9630@infradead.org> <20060520201357.GA32010@taniwha.stupidest.org> <20060520212049.GA11180@taniwha.stupidest.org> <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 07:00:02PM -0300, Matheus Izvekov wrote:

> Why not kill those 2 lines too? Now that non-regparm is gone, it
> doesnt make sense to say there are different ways to pass
> parameters, there is only regparm now, right?

well, i'm not sure that is true everywhere though so i left the
comments
