Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSGaN1w>; Wed, 31 Jul 2002 09:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSGaN1w>; Wed, 31 Jul 2002 09:27:52 -0400
Received: from sprocket.loran.com ([209.167.240.9]:2035 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S318355AbSGaN1v>; Wed, 31 Jul 2002 09:27:51 -0400
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: David Luyer <david_luyer@pacific.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
References: <00c201c23892$1c5fb450$638317d2@pacific.net.au> 
	<1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Jul 2002 09:31:17 -0400
Message-Id: <1028122277.13632.3.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 13:59, David Luyer wrote:
>   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
> }
> luyer@praxis8:~$ ./cpus
> 4

I ran your test program on a Compaq DL360 and an IBM x330
and both showed '2' for the CPU count (2.4.18 stock, glibc 2.2.3)

Just a point of reference to help narrow the problem area down :)

Dana Lacoste
Ottawa, Canada

