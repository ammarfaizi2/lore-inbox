Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWFPQnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWFPQnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWFPQnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:43:14 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:29034 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751490AbWFPQnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:43:14 -0400
Message-ID: <4492EDC7.3010304@oracle.com>
Date: Fri, 16 Jun 2006 10:43:35 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
References: <44909A32.3010304@oracle.com> <20060616113115.181ecb01@doriath.conectiva>
In-Reply-To: <20060616113115.181ecb01@doriath.conectiva>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Fernando N. Capitulino wrote:
> On Wed, 14 Jun 2006 16:22:26 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> | From: Ben Collins <bcollins@ubuntu.com>
> | 
> | [UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
> | interrupts on ACPI EC (embedded controller)
> 
>  Why not the new mutex API?

Yes, of course, as Arjan also said.  Arjan also had some other
good comments about this particular patch.

Thanks,
~Randy

