Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWH3WvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWH3WvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWH3WvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:51:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:34509 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751424AbWH3WvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:51:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s7CDWvxq5CS5Y6z1ym8LPUqt8Bf3KWyH6kT6eDrkg29tW3B4rIRxDccAoqWJMRT2nkJ2jc/C++nJ+MEHg/cnL11ZkWANaTa8exYhcEV1gB4wopYtlGE5K0D/ncjOUKWZPqLOx/Ci1ny9EhxN8Ni03u09ZQtlcSt3Pt9EUL/l2B4=
Message-ID: <44F6164F.6000709@gmail.com>
Date: Thu, 31 Aug 2006 02:50:55 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com> <44F5C5E0.4050201@gmail.com> <20060830175250.GA6258@kroah.com>
In-Reply-To: <20060830175250.GA6258@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Aug 30, 2006 at 09:07:44PM +0400, Manu Abraham wrote:
>> Being a bit excited and it is really interesting to have such a
>> proposal, it would simplify the matters that held us up even more,
>> probably. The name sounds fine though. All i was wondering whether there
>> would be any high latencies for the same using in such a context. But
>> since the transfers would occur in any way, even with a kernel mode
>> driver, i think it should be pretty much fine.
> 
> As mentioned, this framework is being used in industrial settings right
> now, where latencies are a huge issue.  It works just fine, so I do not
> think there are any problems in this area.

Cool.

Is there some way we can avoid the poll ? It would be a real gain
indeed, if a POLL can be avoided.

Regards,
Manu


