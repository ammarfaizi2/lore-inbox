Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSH1WSI>; Wed, 28 Aug 2002 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319027AbSH1WSH>; Wed, 28 Aug 2002 18:18:07 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:4767 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319026AbSH1WSG>; Wed, 28 Aug 2002 18:18:06 -0400
Date: Wed, 28 Aug 2002 18:26:59 -0400
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.32-mm1
Message-ID: <20020828222659.GA16858@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.32-mm1 fixes some page allocation failures on 3.75 GB
quad xeon.  2.5.32 vanilla had a lot of these:

page allocation failure. order:0, mode:0x50

The page alloc failures began showing up in the first few minutes
of testing (dbench).  2.5.32 stopped responding after about 4
hours of testing.

2.5.32-mm1 has been testing for over 14 hours with no
page allocation failures.

2.5.32 didn't have page alloc failures on uniprocessor 384 MB 
machine during 22 hours of testing.
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

