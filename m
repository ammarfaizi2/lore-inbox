Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTEAGPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEAGPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:15:15 -0400
Received: from s4.uklinux.net ([80.84.72.14]:32958 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S262656AbTEAGPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:15:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
References: <200304301946130000.01139CC8@smtp.comcast.net>
	<20030430172102.69e13ce9.rddunlap@osdl.org>
	<9930000.1051762204@[10.10.2.4]> <3EB0BB32.1070500@wmich.edu>
From: Peter Riocreux <peter.riocreux@cakes.org.uk>
Date: 01 May 2003 07:14:21 +0100
In-Reply-To: <3EB0BB32.1070500@wmich.edu>
Message-ID: <9kel3jw5vm.fsf@homer.cakes.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might also help highlight files that are not really in a natural
place in the tree. If people building for x86 platforms start finding
they need a file that is in the sparc part of the tree then that
suggests that said file is probably at least partly non-arch
specific. This would also apply to, say, the audio and video parts of
the drivers section of the tree.

While these things do get reported on here occasionally, and fixed,
making it possible to wholesale remove parts of the tree that people
naturally assume you *shouldn't* need for a particular config ought to
show these up more easily.

Of course it adds another variable into the mix when people report
build problems....

Peter
