Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDMP2u>; Fri, 13 Apr 2001 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDMP2k>; Fri, 13 Apr 2001 11:28:40 -0400
Received: from p244.usslc13.stsn.com ([208.32.226.244]:60176 "EHLO
	hoteldns02.stsn.com") by vger.kernel.org with ESMTP
	id <S131386AbRDMP2h>; Fri, 13 Apr 2001 11:28:37 -0400
Date: Fri, 13 Apr 2001 07:29:06 -0400
Message-Id: <200104131129.f3DBT6619362@golux.thyrsus.com>
From: <esr@golux.thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Happy news for the speed freaks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found the bottleneck in the CML2 configurator's startup time
and nailed it.  On my laptop, the time to read in and commit the i386
defconfig has dropped from 12 seconds to less than 2.  This fix will be
in the next release; expect it late today or tomorrow.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

He that would make his own liberty secure must guard even his enemy from
oppression: for if he violates this duty, he establishes a precedent that
will reach unto himself.
	-- Thomas Paine
