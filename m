Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbTCGKHU>; Fri, 7 Mar 2003 05:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbTCGKHU>; Fri, 7 Mar 2003 05:07:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:34568 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261460AbTCGKHT>; Fri, 7 Mar 2003 05:07:19 -0500
Message-ID: <3E687238.8030504@aitel.hist.no>
Date: Fri, 07 Mar 2003 11:19:36 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
References: <Pine.LNX.4.44.0303070706410.3211-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
 > I believe we should still enable
> application programmers to give certain apps _some_ minor priority boost,
> so that other CPU hogs cannot starve xine.

But we don't really need further kernel support for that, do we?
I know a user currently cannot raise priority, but the user can
run all his normal apps at slightly lower priority, except for xine.
And the admin/distrubutor can set everything up for using the slightly
lower priority by default.  Well, perhaps all this involves so
much use of "nice" that kernel support is a good idea anyway...

Helge Hafting

