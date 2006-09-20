Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWITW0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWITW0b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWITW0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:26:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:18334 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932413AbWITW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:26:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bnt1WZBb5dJ6NGPyBTLpJOWt2rb2rr7n504rWqr0zL4PuOPe14qJMfcI19/u02fNfpwRfNO2zpdEx10rUUmfqJFl06oE2mehf62BvhYk7a+XtaNqzwmwoV5Udn86MdH+f9dkQv2RA7EyRmSH5QNgQQJ4GWyqqApBnFqLY5LCRQo=
Message-ID: <6bffcb0e0609201526q649daa96s7060a630e36542d7@mail.gmail.com>
Date: Thu, 21 Sep 2006 00:26:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rt1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060920141907.GA30765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920141907.GA30765@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/06, Ingo Molnar <mingo@elte.hu> wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded
> from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/

Hibernation doesn't work for me.

echo shutdown > /sys/power/disk; echo disk > /sys/power/state

Freezing cpus...
Breaking affinity for irq 14
Breaking affinity for irq 15
Breaking affinity for irq 19
Breaking affinity for irq 21

Any ideas why?

http://www.stardust.webpages.pl/files/o_bugs/rt/2.6.18-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
