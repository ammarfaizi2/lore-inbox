Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJYSN3>; Fri, 25 Oct 2002 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJYSN3>; Fri, 25 Oct 2002 14:13:29 -0400
Received: from bozo.vmware.com ([65.113.40.131]:38660 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261525AbSJYSN2>; Fri, 25 Oct 2002 14:13:28 -0400
Date: Fri, 25 Oct 2002 11:20:23 -0700
From: chrisl@vmware.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <20021025182023.GA1397@vmware.com>
References: <20021024230229.GA1841@vmware.com> <2897727591.1035509219@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2897727591.1035509219@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Oct 25, 2002 at 01:27:00AM -0700, Martin J. Bligh wrote:
> Define "physical CPU number" ;-) If you want to deteact which

I mean the number of cpu chip you can count on the mother board.

> ones are paired up, I believe that if all but the last bit
> of the apicid is the same, they're siblings. You might have to
> dig the apicid out of the bootlog if the cpuinfo stuff doesn't
> tell you.

And you are right. Those apicid, after mask out the siblings,
are put in phys_cpu_id[] array in kernel.

I think about look at bootlog too, but that is not a reliable
way because bootlog might already been flush out after some
time.

Cheers

Chris



