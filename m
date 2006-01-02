Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWABTS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWABTS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWABTS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:18:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48564 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750973AbWABTS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:18:56 -0500
Date: Mon, 2 Jan 2006 14:17:20 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, mingo@elte.hu, bunk@stusta.de,
       arjan@infradead.org, tim@physik3.uni-rostock.de, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102191720.GI22293@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102110341.03636720.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 11:03:41AM -0800, Andrew Morton wrote:
> > But what _is_ the best idea?
> 
> Just use `inline'.  With gcc-3 it'll be inlined.

Where does this certainity come from?  gcc-3.x (as well as 2.x) each had
its own heuristics which functions should be inlined and which should not.
inline keyword has always been a hint.

	Jakub
