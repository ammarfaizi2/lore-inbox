Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSL1ChC>; Fri, 27 Dec 2002 21:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSL1ChC>; Fri, 27 Dec 2002 21:37:02 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:59060 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265396AbSL1ChB> convert rfc822-to-8bit; Fri, 27 Dec 2002 21:37:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:815! in 2.4.17: jbd initialized twice?
Date: Sat, 28 Dec 2002 03:44:57 +0100
User-Agent: KMail/1.4.3
References: <3E0D1159.10101@kegel.com>
In-Reply-To: <3E0D1159.10101@kegel.com>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212280343.46168.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 December 2002 03:50, Dan Kegel wrote:

Hi Dan,

> Journalled Block Device driver loaded           <------ #1 -------<
> Journalled Block Device driver loaded    <------ #2  -------<
> kmem_cache_create: revoke_record
> kernel BUG at slab.c:816!
I am pretty sure this has been fixed in 2.4.18/2.4.19.

Anyway, for ext3fs usage I recommend at least 2.4.21-pre2 or anything 
2.4.20'ish with ext3fs fixes.

ciao, Marc
