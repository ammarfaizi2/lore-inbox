Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTDBDHS>; Tue, 1 Apr 2003 22:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTDBDHS>; Tue, 1 Apr 2003 22:07:18 -0500
Received: from web20005.mail.yahoo.com ([216.136.225.68]:56651 "HELO
	web20005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261317AbTDBDHQ>; Tue, 1 Apr 2003 22:07:16 -0500
Message-ID: <20030402031840.60077.qmail@web20005.mail.yahoo.com>
Date: Tue, 1 Apr 2003 19:18:40 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap-related questions
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030401125020.E25225@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Benjamin LaHaise <bcrl@redhat.com> wrote:
> the act of unmapping them transfers the
> dirty bit from the page 
> tables into the page cache where fsync() acts on
> them.
>
Should this info be included with Mel Gorman's
excellent doc:
http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/node31.html#SECTION009411000000000000000
Or is it there, but I missed it?

> The
> one case this breaks down 
> on is when the mmap()'d file is on NFS -- the
> reordering there can result in 
> writebacks from mmap()s occuring in unexpected ways.
I sometimes wish mmap was not supported on NFS, or at
least require a special MAP_NFS flag be used.  It has
caused lots of pain over the years.

Thanks again for this info, it has helped greatly!

-Kenny


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
