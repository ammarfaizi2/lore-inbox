Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUKDXGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUKDXGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbUKDWgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:36:40 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:61188 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262339AbUKDWWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:22:05 -0500
Date: Thu, 4 Nov 2004 23:28:16 +0100
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, Jim Nelson <james4765@verizon.net>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104222816.GA15598@hh.idb.hist.no>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD> <200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net> <418A5937.3070707@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418A5937.3070707@rnl.ist.utl.pt>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:30:47PM +0000, Pedro Venda (SYSADM) wrote:
> Jim Nelson wrote:
> >DervishD wrote:
> 
> the exact same happened to me, but my case was with ntfs. zip processes 
> just got stuch in "D" state because of some unhandled names... i 
> couldn't kill the processes. i don't think this is an easy thing to do, 
> tough it should be possible to kill -9 these processes and make them exit.
> 
> is this feasible?
> 
The correct approach here is to fix ntfs so it doesn't make processes
wait forever for anything.  There is no need for a workaround.

Helge Hafting
