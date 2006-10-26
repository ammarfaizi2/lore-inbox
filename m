Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423531AbWJZOlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423531AbWJZOlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423533AbWJZOlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:41:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:47978 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423531AbWJZOlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hel3p1I+VSY+IZXhRhe1QrmKd+f4OkoUmDjsuUfAy6Pcioo/0Js4ULCWa+OWKSl1tBXz/W4+0SeBJ7E235NvN4AXJ610BefkKyISF5cD+KgaH1auXwDuDHaq3UtGVqB8uHB7zg7cnN8M4XALhVA5+WjkeWSeWnyUxVwDpwvxETg=
Message-ID: <4ac8254d0610260741r6e753310t32a796d66225d94a@mail.gmail.com>
Date: Thu, 26 Oct 2006 16:41:03 +0200
From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: IO_APIC broken by 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Cc: linux-kernel@vger.kernel.org, ak@suse.de, yinghai.lu@amd.com
In-Reply-To: <4ac8254d0610250737j5c85161ar9f1f4cdb7c79e743@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ac8254d0610250537m7ee628cbo255decde52586742@mail.gmail.com>
	 <20061025130331.GE3277@rhun.haifa.ibm.com>
	 <4ac8254d0610250737j5c85161ar9f1f4cdb7c79e743@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On 10/25/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > On Wed, Oct 25, 2006 at 02:37:57PM +0200, Tuncer Ayaz wrote:
> > > I've bisected the non-working'ness of HD-Audio and USB Mouse on one of
> > > my x86_64 boxes back to the following commit.
> > >
> > > The machine is an HP xw4400 Core 2 Duo E6600 with the Intel 975X chipset.
> > > Please let me know if you need any debug info.
> >
> > These two patches should fix it:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2
>
> Thanks, a clean v2.6.19-rc3 plus those two patches solves the issues.
> I assume that the fixes will be pulled into Linus' tree before 2.6.19
> is released.

Linus' tree as of this morning CEST time has the two patches included and
everything's fine. Case closed.
