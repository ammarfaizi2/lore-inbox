Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTFDATr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTFDATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:19:47 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:59657 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262011AbTFDATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:19:44 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Daniel.A.Christian@NASA.gov, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
Date: Wed, 4 Jun 2003 02:32:57 +0200
User-Agent: KMail/1.5.2
References: <200306031728.41982.Daniel.A.Christian@NASA.gov>
In-Reply-To: <200306031728.41982.Daniel.A.Christian@NASA.gov>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306040232.16281.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 02:28, Dan Christian wrote:

Hi Dan,

> I can build a 2.4.21-rc7 Athlon single processor kernel and modules
> without problem.
> When I enable SMP, most (but not all) modules have unresolved symbols.
> This is basic stuff like prink and kmalloc.  I've tried both with and
> without symbol versioning.
> The build line was:
> make clean && make dep && make bzImage && make modules && make
> modules_install
> I'm building on RedHat 7.3.
> #rpm -q gcc binutils modutils
> gcc-2.96-113
> binutils-2.11.93.0.2-11
> modutils-2.4.18-3.7x
> I'm not on the list.  Please CC me.
w/o your .config a most impossible mission to fix this up.

Just a guess: Did you switch from UP to SMP with out doing "make mrproper"?

ciao, Marc

