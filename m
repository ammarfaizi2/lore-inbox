Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSJJVPq>; Thu, 10 Oct 2002 17:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263608AbSJJVPq>; Thu, 10 Oct 2002 17:15:46 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:52214 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263589AbSJJVPp>; Thu, 10 Oct 2002 17:15:45 -0400
Date: Thu, 10 Oct 2002 17:21:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: Fork timing numbers for shared page tables
Message-ID: <20021010172130.A11796@redhat.com>
References: <167610000.1034278338@baldur.austin.ibm.com> <3DA5D893.CDD2407C@digeo.com> <175360000.1034279947@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <175360000.1034279947@baldur.austin.ibm.com>; from dmccr@us.ibm.com on Thu, Oct 10, 2002 at 02:59:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 02:59:07PM -0500, Dave McCracken wrote:
> I don't know why exec introduces a small penalty for small tasks. I'm
> working on some optimizations that might help.

Compare against vfork() to see what kind of best case is possible, and 
how much of the overhead in small tasks is just in non-vm overhead.

		-ben
