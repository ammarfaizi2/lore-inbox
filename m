Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJIJ3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 05:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJIJ3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 05:29:06 -0400
Received: from c-36a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.54]:900
	"EHLO ford.pronto.tv") by vger.kernel.org with ESMTP
	id S261947AbTJIJ24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 05:28:56 -0400
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
References: <yw1xoewrfizk.fsf@users.sourceforge.net>
	<1065655452.13572.50.camel@torrey.et.myrio.com>
	<yw1xad8bfg6q.fsf@users.sourceforge.net>
	<1065660704.848.10.camel@slurv>
	<yw1x1xtmg57y.fsf@users.sourceforge.net>
	<1065690658.10389.19.camel@slurv>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 09 Oct 2003 11:28:49 +0200
In-Reply-To: <1065690658.10389.19.camel@slurv> (Andre Tomt's message of
 "Thu, 09 Oct 2003 11:10:59 +0200")
Message-ID: <yw1xoewqep4e.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt <andre@tomt.net> writes:

>> > Was this a 4 port or 2 port HPT controller? Keep in mind, two disks on
>> > the same IDE channel severely degrades performance, *especially* with
>> > RAID.
>> 
>> It's a four port SATA controller.  I'd never even think about placing
>> two disks on the same cable.
>
> You can't either, considering it is SATA :-)
>
> However, I wouln't count on superior performance from software based
> RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
> are for.

I've seen reports of people obtaining nearly 100 MB/s from software
RAID5.

> Out of couriosity, how well is it performing in lets say.. a RAID10 or
> RAID1 setup?

I didn't try.  I might, of course.

-- 
Måns Rullgård
mru@users.sf.net
