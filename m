Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSLBHWR>; Mon, 2 Dec 2002 02:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLBHVg>; Mon, 2 Dec 2002 02:21:36 -0500
Received: from web14503.mail.yahoo.com ([216.136.224.66]:54709 "HELO
	web14503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265513AbSLBHUU>; Mon, 2 Dec 2002 02:20:20 -0500
Message-ID: <20021202072747.28227.qmail@web14503.mail.yahoo.com>
Date: Sun, 1 Dec 2002 23:27:47 -0800 (PST)
From: Arun Prasad Velu <arun_linux@yahoo.com>
Subject: Re: Allocating huge memeory in loadable kernel module
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.1.6.2.20021202061729.00cceeb0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<If your module is expected to be loaded into an 
unmodified kernel though, that would be a problem.
>>Yes. Thats the problem and requirement.

Arun

--- Mike Galbraith <efault@gmx.de> wrote:
Hi,

The only way I know of to do this is to use the
bootmem interface to 
steal/reserve ram.  If your module is expected to be
loaded into an 
unmodified kernel though, that would be a problem.

         -Mike


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
