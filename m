Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVDXAmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVDXAmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVDXAmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:42:47 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24243 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262205AbVDXAmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:42:45 -0400
Date: Sat, 23 Apr 2005 17:42:27 -0700
From: Paul Jackson <pj@sgi.com>
To: kaih@khms.westfalen.de (Kai Henningsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050423174227.51360d63.pj@sgi.com>
In-Reply-To: <9VF1rZLXw-B@khms.westfalen.de>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050410065307.GC13853@64m.dyndns.org>
	<d3dvps$347$1@terminus.zytor.com>
	<9VF1rZLXw-B@khms.westfalen.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's an unavoidable  
> result of using less bits than the original data has.

Even _not_ using a hash will have collisions - copy different globs of
data around enough, and sooner or later, two globs that started out
different will end up the same, due to errors in our computers.  Even
ECC on all the buses, channels, and memory will just reduce this chance.

There is no mathematical perfection obtainable here.  Deal with it.

Computers are about engineering, not philosophical perfection.

If something is likely to happen less than once in a billion years,
then for all practical purposes, it won't happen.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
