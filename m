Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVHRDTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVHRDTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 23:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVHRDTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 23:19:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42440 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932120AbVHRDTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 23:19:05 -0400
Date: Wed, 17 Aug 2005 20:19:02 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH 1/32] include: update jiffies/{m,u}secs conversion functions
Message-ID: <20050818031902.GB4398@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com> <20050815180617.GD2854@us.ibm.com> <20050817163506.58e37fb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817163506.58e37fb0.akpm@osdl.org>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2005 [16:35:06 -0700], Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > Description: Clarify the human-time units to jiffies conversion
> > functions by using the constants in time.h. This makes many of the
> > subsequent patches direct copies of the current code.
> > 
> >  
> >  /* Parameters used to convert the timespec values */
> > +#ifndef MSEC_PER_SEC
> > +#define MSEC_PER_SEC (1000L)
> > +#endif
> > +
> >  #ifndef USEC_PER_SEC
> >  #define USEC_PER_SEC (1000000L)
> >  #endif
> 
> Bah.  There's no MSEC_PER_SEC defined anywhere in the tree, so the ifndef
> isn't needed.  Nor is the one for USEC_PER_SEC, come to that.  I'll kill
> them.

Yup, that's fine by me. Thanks!

-Nish
