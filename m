Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTKLPCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKLPBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:01:41 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:49595 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262076AbTKLPBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:01:35 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl>
	<20031110165406.GM22185@fs.tum.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Nov 2003 15:40:49 +0100
In-Reply-To: <20031110165406.GM22185@fs.tum.de>
Message-ID: <m3znf18xam.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

> A -rc kernel of a stable series needs maximum testing to avoid any 
> regressions compared to the previous stable kernel.
> 
> If you start a new -pre series at the time of an -rc series many people 
> will use the new -pre instead of the latest -rc decreasing the number of 
> people testing this -rc and therefore increasing the risk of problems in 
> the final kernel.

Not exactly - the X-pre kernel would contain all patches contained in
X-1-rc available at the time. While there is a (relatively small) chance
that a subset of independent patches breaks things while the complete set
does not, all patches contained in -rc would be tested by both rc and pre
users.

Of course, many people would stick to -rc patches only, and others would
use just final kernels.
-- 
Krzysztof Halasa, B*FH
