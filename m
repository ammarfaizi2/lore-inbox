Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSANVFW>; Mon, 14 Jan 2002 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSANVFO>; Mon, 14 Jan 2002 16:05:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39947 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289056AbSANVFC>;
	Mon, 14 Jan 2002 16:05:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts 
In-Reply-To: Your message of "Mon, 14 Jan 2002 15:19:00 BST."
             <Pine.GSO.3.96.1020114150024.16706C-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 08:04:50 +1100
Message-ID: <31989.1011042290@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 15:19:00 +0100 (MET), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> The "noapic" option should probably get removed -- it was meant as a
>debugging aid (as many of the "no*" options) at the early days of I/O APIC
>support, I believe...  Now the support is pretty stable.

Intel 440GX chipsets hang during SCSI probe with UP kernels unless you
use noapic.  It works with SMP but many installers use UP kernels.
Removing noapic will break install on all 440GX machines, there are a
lot of them out there.

