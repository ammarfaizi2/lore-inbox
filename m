Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbRDJFvu>; Tue, 10 Apr 2001 01:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDJFvl>; Tue, 10 Apr 2001 01:51:41 -0400
Received: from ns.suse.de ([213.95.15.193]:33810 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132934AbRDJFvg>;
	Tue, 10 Apr 2001 01:51:36 -0400
Date: Tue, 10 Apr 2001 07:51:09 +0200
From: Andi Kleen <ak@suse.de>
To: Mark Salisbury <mbs@mc.com>
Cc: Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410075109.A9549@gruyere.muc.suse.de>
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01040914220214.01893@pc-eng24.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01040914220214.01893@pc-eng24.mc.com>; from mbs@mc.com on Mon, Apr 09, 2001 at 02:19:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 02:19:28PM -0400, Mark Salisbury wrote:
> this is one of linux biggest weaknesses.  the fixed interval timer is a
> throwback.  it should be replaced with a variable interval timer with interrupts
> on demand for any system with a cpu sane/modern enough to have an on-chip
> interrupting decrementer.  (i.e just about any modern chip)

Just how would you do kernel/user CPU time accounting then ?  It's currently done 
on every timer tick, and doing it less often would make it useless.


-Andi
