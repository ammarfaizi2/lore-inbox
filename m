Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264678AbSKDOWx>; Mon, 4 Nov 2002 09:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbSKDOWw>; Mon, 4 Nov 2002 09:22:52 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:50851 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264678AbSKDOWw>;
	Mon, 4 Nov 2002 09:22:52 -0500
Date: Mon, 4 Nov 2002 14:27:03 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undeclared NULL in timer.h
Message-ID: <20021104142703.GA20234@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021104083918.126192C27F@lists.samba.org> <200211041139.gA4Bdjp32237@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211041139.gA4Bdjp32237@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:31:39PM -0200, Denis Vlasenko wrote:
 > The whole problem of #include forest going out of control
 > needs some clever solution or we will eternally chase missing
 > .h files

Doing an untangle at this point is pretty much a waste of effort.
As we get closer to stabilising, we can regenerate the dependancy
graphs and see what looks out of place again.

Adding lots of #include's isn't an issue as long as those includes
aren't sucking in 200 others.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
