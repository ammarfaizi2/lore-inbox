Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWJYOhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWJYOhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWJYOhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:37:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:17532 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030461AbWJYOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:37:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fulwn/H5nOuWel6Oqp18sJkoFPQXbKE5ioHWVvsRS1/3ER/ZDI+RXKOf9ijtuzRcph0qfibNE1DO0Pv3z5bZWoHYVo96KA12LSodTedhpNuEJd39IN4xXge4M0+UdfJ8C0wJcOPgrVE0VZcOUBobmbxPUxCa+KpxLeyFkiYM30o=
Message-ID: <4ac8254d0610250737j5c85161ar9f1f4cdb7c79e743@mail.gmail.com>
Date: Wed, 25 Oct 2006 16:37:21 +0200
From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: IO_APIC broken by 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Cc: linux-kernel@vger.kernel.org, ak@suse.de, yinghai.lu@amd.com
In-Reply-To: <20061025130331.GE3277@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ac8254d0610250537m7ee628cbo255decde52586742@mail.gmail.com>
	 <20061025130331.GE3277@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> On Wed, Oct 25, 2006 at 02:37:57PM +0200, Tuncer Ayaz wrote:
> > I've bisected the non-working'ness of HD-Audio and USB Mouse on one of
> > my x86_64 boxes back to the following commit.
> >
> > The machine is an HP xw4400 Core 2 Duo E6600 with the Intel 975X chipset.
> > Please let me know if you need any debug info.
>
> These two patches should fix it:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2

Thanks, a clean v2.6.19-rc3 plus those two patches solves the issues.
I assume that the fixes will be pulled into Linus' tree before 2.6.19
is released.
