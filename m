Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTJQTS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTJQTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:18:27 -0400
Received: from main.gmane.org ([80.91.224.249]:46493 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263505AbTJQTS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:18:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Software RAID5 with 2.6.0-test
Date: Fri, 17 Oct 2003 21:18:24 +0200
Message-ID: <yw1xllrjk70f.fsf@users.sourceforge.net>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com>
 <yw1xu167kbcw.fsf@users.sourceforge.net> <3F903768.7060803@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:emZKyOzpacSRRFnfh1npf/a/6TE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory <sflory@rackable.com> writes:

>> What about the RAID controllers in the $400 category?  Surely, they
>> must be doing something better than the $50 fakeraid controllers.
>>
>
>    Yes, but follow this logic.
>
> 1)You are willing to devote 10% of 2Ghz xeon to software raid.
> 2)A $500+ controller has a 100Mhz proccessor.
>
>    Thus just from this you could guess that software raid has x2 as
>    many clock cycles availble to it.  It's even worse when you realize
>    the 2Ghz xeon is a better proccessor in many more ways than just
>    clock cycles.

How about this logic:

1) If the processor on the RAID controller can handle the full
bandwidth of the disks, it's fast enough.
2) If someone else does the 10% work, the CPU can do 10% more work.

-- 
Måns Rullgård
mru@users.sf.net

