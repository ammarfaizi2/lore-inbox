Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUGZTOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUGZTOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUGZTOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:14:02 -0400
Received: from main.gmane.org ([80.91.224.249]:31199 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266013AbUGZRVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 13:21:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: Interesting race condition...
Date: Mon, 26 Jul 2004 17:20:54 +0000 (UTC)
Message-ID: <loom.20040726T190852-691@post.gmane.org>
References: <200407222204.46799.rob@landley.net> <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net> <200407240313.19053.rob@landley.net> <loom.20040724T152713-574@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.128.251.122 (Mozilla/5.0 (compatible; Konqueror/3.2; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin <Ballarin.Marc <at> gmx.de> writes: 
 
Ok, I could repruduce this issue in bash and tcsh, using both, procps 
3.1.5/3.2.2 from procps.sourceforge.net and procps 2.0.16 from 
tech9.net/rml/procps. 
 
So, the bug is not in the shell (which is obvious, on second thought), but in 
the kernel, glibc or procps - or the combination thereof. 
 
I'm using kernel 2.6.7, gcc-3.3.3, and glibc-2.3.3 with NPTL on Gentoo. 
 
Regards 

