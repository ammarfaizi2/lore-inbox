Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbTEJMFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTEJMFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 08:05:08 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:40873 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264068AbTEJMFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 08:05:07 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
To: wli@holomorphy.com, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Reply-To: tomlins@cam.org
Date: Sat, 10 May 2003 08:18:23 -0400
References: <fa.f4fihqc.4kq986@ifi.uio.no> <fa.clherio.l2of82@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030510121823.7C67EAE6@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I reported one of the bugs.  I now am running mm3 with the rusty fix  
backed out and the two davem fixes applied.  Uptime is over one day.  Looks
to be fixed here.

Thanks
Ed

Jens Axboe wrote:

> On Sat, May 10 2003, William Lee Irwin III wrote:
>> On Thu, May 08 2003, Helge Hafting wrote:
>> >> Much fuzz and two rejects.  Seems there is ongoing netfilter
>> >> work in mm3.
>> 
>> On Thu, May 08, 2003 at 03:37:44PM +0200, Jens Axboe wrote:
>> > akpm applied the patch rusty sent, you'd surely want to back that out
>> > first.
>> > dunno what else is in -mm, the patch reversed without incident on
>> > 2.5-bk as of right now.
>> 
>> It looks like rusty's patch only caught one of two bugs of the same
>> flavor and davem cleaned up the second. It looks like we're in good
>> shape on both fronts from where I'm standing but we should probably
>> wait for all of the original bugreporters to get back to use to
>> declare success on all fronts.
> 
> As I wrote yesterday, bk-current has the fix from Davem that works for
> me.
> 

