Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTDPQOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264475AbTDPQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:14:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23236
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264473AbTDPQOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:14:38 -0400
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com
In-Reply-To: <UTC200304161516.h3GFGRW23387.aeb@smtp.cwi.nl>
References: <UTC200304161516.h3GFGRW23387.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050506897.28591.124.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 16:28:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 16:16, Andries.Brouwer@cwi.nl wrote:
> All traces of ide_xlate_1024 have been removed.
> Few people need it, and sometimes it was directly
> harmful. (And it is dead code in 2.5.recent.)
> There are now boot options "remap" and "remap63"
> for people with EZD or DM.

There are lots of people with remap/remap63 needs. This should be automated
as it was before or it will be a nightmare. You are desperate to remove
the ide_xlate stuff but you can't do that without providing equivalent
automatic functionality, either thats in base or that the vendors all
just merge anyway.


