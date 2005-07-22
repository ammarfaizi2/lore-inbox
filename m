Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVGVOZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVGVOZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGVOZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:25:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46573 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262098AbVGVOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:25:22 -0400
Subject: Re: Kernel doesn't free Cached Memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vinicius <jdob@ig.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722_112730_062779.jdob@ig.com.br>
References: <20050722_112730_062779.jdob@ig.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 15:49:49 +0100
Message-Id: <1122043789.9478.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 08:27 -0300, Vinicius wrote:
> Hi all! 
> 
>    I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, this 
> server runs lots of applications that consume lots of memory to. When I stop 
> this applications, the kernel doesn't free memory (the  memory still in use) 

See any FAQ on the Linux memory management - memory is reclaimed when
needed not when nobody is using it. That makes things more efficient.

> and the server cache lots of memory (~27GB). When I start this applications, 
> the kernel sends  "Out of Memory" messages and kill some random 
> applications. 

Some RHEL3 kernels had a problem with very large memory sizes and 2.4.
That should not be the case in the current RHEL3 kernels. 2.6 handles
very large systems a lot lot better, and of course the fact real
computers now have 64bit processors has also rather improved life.

Alan

 
