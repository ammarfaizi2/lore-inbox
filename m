Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSHHSD4>; Thu, 8 Aug 2002 14:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSHHSD4>; Thu, 8 Aug 2002 14:03:56 -0400
Received: from holomorphy.com ([66.224.33.161]:27290 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317278AbSHHSDy>;
	Thu, 8 Aug 2002 14:03:54 -0400
Date: Thu, 8 Aug 2002 11:07:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: further IO-APIC oddities
Message-ID: <20020808180743.GD15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20020808162856.GD6256@holomorphy.com> <70720000.1028829388@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <70720000.1028829388@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Strange thing happened when I booted the latest x86 discontigmem stuff.
>> The stuff where the IO-APIC ID's showed up as zeroed out went away,
>> and io_apic.c just bitched about the MPC table entries because it
>> doesn't realize that physid's of IO-APIC's mean squat on this box.
>> *AND* whatever was scribbling over that table & zeroing it out went
>> away. That bug is reproducible on more garden variety machines too.
>> If someone who knows how to read the IO-APIC map dumps is around,
>> I've included the boot log below.

On Thu, Aug 08, 2002 at 10:56:28AM -0700, Martin J. Bligh wrote:
> I can kind of read them if I really squint, but what are you trying
> to see / fix?

It's different from 2.5.29, I can follow up with that. 2.5.29 saw all 0's,
so whatever it was that was scribbling over the MPC table and making the
ID's all 0, it's scribbling on something else now (probably mem_map).


Cheers,
Bill
