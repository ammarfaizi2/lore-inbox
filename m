Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTAPHET>; Thu, 16 Jan 2003 02:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTAPHET>; Thu, 16 Jan 2003 02:04:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29920 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261829AbTAPHET>; Thu, 16 Jan 2003 02:04:19 -0500
Date: Wed, 15 Jan 2003 23:13:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: dipankar@in.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: lots of calls to __write/read_lock_failed
Message-ID: <59570000.1042701186@titus>
In-Reply-To: <20030116065940.GA4801@in.ibm.com>
References: <3E263285.2000204@us.ibm.com> <20030116044600.GN919@holomorphy.com> <20030116065940.GA4801@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
>> > time:_raw_write_lock() 1350000
>> > Call Trace:
>> >  [<c010f321>] timer_interrupt+0x99/0x9c
>> >  [<c010b150>] handle_IRQ_event+0x38/0x5c
>> 
>> read_lock_irqsave(&xtime_lock, flags)
>> or
>> write_lock_irq(&xtime_lock);
> 
> ISTR a patch from Stephen Hemminger at OSDL that used Andrea's
> sequence number trick based rwlock (frlock) to implement do_gettimeofday.
> It might be relevant here.

I thought that was Andi. If it's the patch I'm thinking of, it's sitting
in the -mm tree.

M.

