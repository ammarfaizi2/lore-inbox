Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTFCXQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFCXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:16:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21122
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261840AbTFCXQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:16:40 -0400
Subject: Re: NPTL/SMP/NUMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Voorsluys <william@icmc.usp.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.05.10306031914120.1819-100000@ceci>
References: <Pine.GSO.4.05.10306031914120.1819-100000@ceci>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054679535.9233.87.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 23:32:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 23:26, William Voorsluys wrote:
> thinking on SMP machines, and which have been made to other purposes?
> Is there any feature on the library/kernel that make it possible to
> exploit the benefits of NUMA systems?

NUMA systems don't have any benefits (well other than engineering 
considerations like practicality of construction). From a software
perspective NUMA is simply a question of making the loss as little
as possible.

There are patches to do more NUMA aware scheduling which help a bit
as well as to do things like replicate the kernel code to each node.

