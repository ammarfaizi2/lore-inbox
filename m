Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSIPS7v>; Mon, 16 Sep 2002 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbSIPS7v>; Mon, 16 Sep 2002 14:59:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25746 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263137AbSIPS7u> convert rfc822-to-8bit; Mon, 16 Sep 2002 14:59:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Alan Cox <alan@redhat.com>, davej@suse.de (Dave Jones)
Subject: Re: [PATCH] Summit patch for 2.5.34
Date: Mon, 16 Sep 2002 12:03:21 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
       torvalds@transmeta.com, alan@redhat.com, mingo@redhat.com
References: <200209161615.g8GGFqx10004@devserv.devel.redhat.com>
In-Reply-To: <200209161615.g8GGFqx10004@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209161203.21815.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 09:15 am, Alan Cox wrote:
> > - Is this the same summit code as is in 2.4-ac ?
> >   (Ie, the one that boots on non summit systems too)
>
> Yes

It's the same, save for a few lines of code that use the local APIC's task 
priority HW to try for some better dynamic interrupt balancing.

> > - I believe the way forward here is to work with James Bottomley,
> >   who has a nice abstraction of the areas your patch touches for
> >   his Voyager sub-architecture.
>
> For 2.5 maybe not for 2.4. Until Linus takes the subarch stuff the
> if if if bits will just get uglier. As well as voyager there are at least
> two more pending NUMA x86 platforms other than IBM summit
> -

I'll have to read up on James Bottomley's x86 subarch code.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

