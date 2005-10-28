Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVJ1P37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVJ1P37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVJ1P37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:29:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24737 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030194AbVJ1P36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:29:58 -0400
To: "Alejandro Bonilla" <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	<20051027204923.M89071@linuxwireless.org>
	<1130446667.5416.14.camel@blade>
	<20051027205921.M81949@linuxwireless.org>
	<1130447261.5416.20.camel@blade>
	<20051027211203.M33358@linuxwireless.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 09:29:34 -0600
In-Reply-To: <20051027211203.M33358@linuxwireless.org> (Alejandro Bonilla's
 message of "Thu, 27 Oct 2005 17:15:50 -0400")
Message-ID: <m1mzktbqxt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alejandro Bonilla" <abonilla@linuxwireless.org> writes:

>> so there is no way to give me back the "lost" memory. Is it possible
>> that another motherboard might help?
>
> AFAIK, No. AMD and Intel will always do the same thing until we all move to
> real IA64.

IA64 inherits this part of the architecture from x86, so no magic fix.
This is a fundamentally a chipset limitation, not an architectural bug.

rev-E amd64 cpus from AMD all have memory hoisting support,
as do all server chipsets from Intel for the last several years.

To avoid this you just need a good chipset and a good BIOS implementation.
Any recent server board should be fine.  Hopefully the desktop boards
will catch up soon.

Eric
