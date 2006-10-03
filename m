Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWJCREZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWJCREZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWJCREY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:04:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36082 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030312AbWJCREX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:04:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m3fRNDtjoLrF3rJTqoTcqPaOASDXNTMo2Kz1XcLfMCoqLRW4cm5T6eD/1q3/kXix8mNrhGp9ytQ2rYm68oVG+vtRMWf8aQZXc12kMpuYqmWfhaMVlWCeyfyop1GoxXmK0tzM01gUzkqXpnUgURHXyBGmnC3NHicGXrmUm5sRlkY=
Message-ID: <f4527be0610031004w27969892n92c48c96fad138db@mail.gmail.com>
Date: Tue, 3 Oct 2006 18:04:21 +0100
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: SATA CD/DVDRW Support in 2.6.18?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45224554.8030005@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
	 <45224554.8030005@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Lyon wrote:
> >
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ..
> > It looks like the interface is trying to run at 1.5Gbps which is
> > obviously too fast for this drive
>
> No, with SATA the only two choices available today are 1.5gb/s and 3.0gb/s.
> The speed-down fault-recovery logic in libata is kinda bogus for genuine SATA.
> Something else must be wrong in your situation.
>

I have checked everything I can think of:

tested that particular interface with two different hard drives
tried new sata cable
tested drive in windows
checked for updated drive firmware
tried different media

I cannot find anything wrong.

andy
