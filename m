Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTJIIzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTJIIzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:55:53 -0400
Received: from c-36a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.54]:57473
	"EHLO ford.pronto.tv") by vger.kernel.org with ESMTP
	id S261946AbTJIIzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:55:51 -0400
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
References: <yw1xoewrfizk.fsf@users.sourceforge.net>
	<1065655452.13572.50.camel@torrey.et.myrio.com>
	<yw1xad8bfg6q.fsf@users.sourceforge.net>
	<1065660704.848.10.camel@slurv>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 09 Oct 2003 10:55:45 +0200
In-Reply-To: <1065660704.848.10.camel@slurv> (Andre Tomt's message of "Thu,
 09 Oct 2003 02:51:44 +0200")
Message-ID: <yw1x1xtmg57y.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt <andre@tomt.net> writes:

>> When I tried it, I was running 2.6.0-test4.  The RAID5 was 4 120 GB
>> Seagate disks on a Highpoint controller.
>
> <snip>
>
>> The other thing that I don't like, is the performance of the RAID
>> array.  The disks individually give ~40 MB/s read speed, but the array
>> only measures 25 MB/s.  I was of the impression, that RAID5 would give
>> read speeds at least equal to the underlying disks.  Is this
>> incorrect?
>
> Was this a 4 port or 2 port HPT controller? Keep in mind, two disks on
> the same IDE channel severely degrades performance, *especially* with
> RAID.

It's a four port SATA controller.  I'd never even think about placing
two disks on the same cable.

-- 
Måns Rullgård
mru@users.sf.net
