Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRLESbG>; Wed, 5 Dec 2001 13:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284543AbRLESaq>; Wed, 5 Dec 2001 13:30:46 -0500
Received: from air-1.osdl.org ([65.201.151.5]:40977 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S275973AbRLESaf>;
	Wed, 5 Dec 2001 13:30:35 -0500
Date: Wed, 5 Dec 2001 10:26:46 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Michael Smith <smithmg@agere.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbol memset
In-Reply-To: <009001c17db9$42aa18b0$4d129c87@agere.com>
Message-ID: <Pine.LNX.4.33L2.0112051024340.22241-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Michael Smith wrote:

| Hello all,
|      I am new the Linux world and have a problem which is somewhat
| confusing.  I am using the system call memset() in kernel code written
| for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible with
| Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
| This is only happening in one place of the code in one file.  I am using
| memset() in other areas of the code which does not lead to the problem.
| If anyone can clue me in to what this possible can be, it would greatly
| be appreciated.

um, memset() isn't actually a system call.
However-- does the problem source file have
#include <linux/string.h>
in it?  It should.
Or perhaps you could post the problem source file and/or
gcc messages.

-- 
~Randy

