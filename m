Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbUDNKE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDNKE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:04:28 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:7172 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264022AbUDNKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:04:25 -0400
Date: Wed, 14 Apr 2004 11:08:14 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: arjanv@redhat.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [0/3]
Message-ID: <8822415.1081940894@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <1081933442.4688.6.camel@laptop.fenrus.com>
References: <200404132317.i3DNH4F21162@unix-os.sc.intel.com>
 <1081933442.4688.6.camel@laptop.fenrus.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 14 April 2004 11:04 +0200 Arjan van de Ven <arjanv@redhat.com> wrote:

> On Wed, 2004-04-14 at 01:17, Chen, Kenneth W wrote:
>> In addition to the hugetlb commit handling that we've been working on
>> off the list, Ray Bryant of SGI and I are also working on demand paging
>> for hugetlb page.  Here are our final version that has been heavily
>> tested on ia64 and x86.  I've broken the patch into 3 pieces so it's
>> easier to read/review, etc.
> 
> Ok I think it's time to say "HO STOP" here.

I would say yes for 2.7.  Then things like actual swapping of large pages
and the like could be done properly.

> If you're going to make the kernel deal with different, concurrent page
> sizes then please do it for real. Or alternatively leave hugetlb to be
> the kludge/hack it is right now. Anything inbetween is the road to
> madness...

The original request was not to generify for 2.6.  Thus all of this work
has been to fix or improve the usability of the kludge without removing its
cancerous sore like nature.  I think that requires a radical rethink and is
not 2.6 material.

-apw
