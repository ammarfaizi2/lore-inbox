Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVHJCv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVHJCv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 22:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHJCv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 22:51:58 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:50650 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964896AbVHJCv6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 22:51:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WP3oQbYjqk7rz8UMm5Ne9/IUm0h9qNaj7LW1mSwIK8RUARBuzRYSvWGlGXFmuX8zMjZZ+kH2QjH9YXQomvhZA6GyPJgqq7aY9aEbwAFlzaQZfeY+jagCE/YsWAz98cNP+JXLUfY+3Zgt2fzdkSy3NEX5jENQoWLO7UvyyaYDzYM=
Message-ID: <86802c4405080919514772d1c@mail.gmail.com>
Date: Tue, 9 Aug 2005 19:51:53 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: smbus driver for ati xpress 200m
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050809225756.GA19772@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <86802c440508091150609eecca@mail.gmail.com>
	 <20050809225756.GA19772@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlunb:/proc/acpi/battery/BAT1 # cat info
present:                 yes
design capacity:         4800 mAh
last full capacity:      4435 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 300 mAh
design capacity low:     132 mAh
capacity granularity 1:  32 mAh
capacity granularity 2:  32 mAh
model number:            ZF02
serial number:           836
battery type:            LION
OEM info:                SIMPLO
yhlunb:/proc/acpi/battery/BAT1 # cat state
present:                 yes
ERROR: Unable to read battery status



On 8/9/05, Andi Kleen <ak@suse.de> wrote:
> On Tue, Aug 09, 2005 at 11:50:53AM -0700, yhlu wrote:
> > anyone is working on add driver for ati xpress 200m?
> >
> > without that My turion notebook, can not work read the battery status.
> 
> Normally this should be done in ACPI battery.c
> 
> -Andi
>
