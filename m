Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTCCMmc>; Mon, 3 Mar 2003 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTCCMmc>; Mon, 3 Mar 2003 07:42:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51098
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264908AbTCCMmb>; Mon, 3 Mar 2003 07:42:31 -0500
Subject: Re: [CHECKER] potential deadlocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303030605.h2365oK08706@csl.stanford.edu>
References: <200303030605.h2365oK08706@csl.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046699795.5889.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 13:56:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 06:05, Dawson Engler wrote:
> BTW, are there known deadlocks (harmless or otherwise)?  Debugging
> the checker is a bit hard since false negatives are silent...

2.4.21pre5 has one in the scsi reset handler for ide-scsi, however its going to
depend on your tools following function pointer chains and stuff to
find it I fear

