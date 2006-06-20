Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWFTWpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWFTWpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWFTWpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:45:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49125 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751358AbWFTWpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:45:18 -0400
Message-ID: <44987A6E.6010608@garzik.org>
Date: Tue, 20 Jun 2006 18:45:02 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Greg KH <gregkh@suse.de>,
       Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/25] msi: Make the msi boolean tests return either 0
 or 1.
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com>
In-Reply-To: <1150842520235-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> This allows the output of the msi tests to be stored directly
> in a bit field.  If you don't do this a value greater than
> one will be truncated and become 0.  Changing true to false
> with bizare consequences.

Another example of why bit fields are a pain in the butt...

	Jeff



